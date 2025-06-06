{
  gtk3,
  gdk-pixbuf,
  librsvg,
  webp-pixbuf-loader,
  gobject-introspection,
  glib-networking,
  glib,
  shared-mime-info,
  gsettings-desktop-schemas,
  wrapGAppsHook,
  gtk-layer-shell,
  gnome,
  libxkbcommon,
  libdbusmenu-gtk3,
  libpulseaudio,
  libinput,
  libevdev,
  openssl,
  luajit,
  luajitPackages,
  pkg-config,
  installShellFiles,
  adwaita-icon-theme,
  hicolor-icon-theme,
  rustPlatform,
  lib,
  version ? "git",
  features ? [],
  builderName ? "nix",
  builder ? {},
}: let
  hasFeature = f: features == [] || builtins.elem f features;

  basePkg = rec {
    inherit version;

    pname = "ironbar";

    src = let
      fs = lib.fileset;
      root = ../.;
      nixRelated = fs.fileFilter (file: file.hasExt "nix" || file.name == "flake.lock") root;
      cicdRelated = fs.unions [
        (lib.path.append root "Dockerfile")
        (lib.path.append root ".github")
      ];
      ideRelated = fs.unions [
        (lib.path.append root ".idea")
      ];
    in fs.toSource {
      inherit root;
      # NOTE: can possibly filter out more
      fileset = fs.difference root (fs.unions [
        nixRelated
        cicdRelated
        ideRelated
      ]);
    };

    nativeBuildInputs = [
      pkg-config
      wrapGAppsHook
      gobject-introspection
      installShellFiles
    ];

    buildInputs =
      [
        gtk3
        gdk-pixbuf
        glib
        gtk-layer-shell
        glib-networking
        shared-mime-info
        adwaita-icon-theme
        hicolor-icon-theme
        gsettings-desktop-schemas
        libxkbcommon
      ]
      ++ lib.optionals (hasFeature "http") [openssl]
      ++ lib.optionals (hasFeature "tray") [libdbusmenu-gtk3]
      ++ lib.optionals (hasFeature "volume") [libpulseaudio]
      ++ lib.optionals (hasFeature "cairo") [luajit]
      ++ lib.optionals (hasFeature "keyboard") [libinput libevdev];

    propagatedBuildInputs = [gtk3];

    lgi = luajitPackages.lgi;

    gappsWrapperArgs =
      ''
        # Thumbnailers
            --prefix XDG_DATA_DIRS : "${gdk-pixbuf}/share"
            --prefix XDG_DATA_DIRS : "${librsvg}/share"
            --prefix XDG_DATA_DIRS : "${webp-pixbuf-loader}/share"
            --prefix XDG_DATA_DIRS : "${shared-mime-info}/share"

            # gtk-launch
            --suffix PATH : "${lib.makeBinPath [gtk3]}"
      ''
      + lib.optionalString (hasFeature "cairo") ''
        --prefix LUA_PATH : "./?.lua;${lgi}/share/lua/5.1/?.lua;${lgi}/share/lua/5.1/?/init.lua;${luajit}/share/lua/5.1/\?.lua;${luajit}/share/lua/5.1/?/init.lua"
        --prefix LUA_CPATH : "./?.so;${lgi}/lib/lua/5.1/?.so;${luajit}/lib/lua/5.1/?.so;${luajit}/lib/lua/5.1/loadall.so"
      '';

    preFixup = ''
      gappsWrapperArgs+=(
        ${gappsWrapperArgs}
      )
    '';

    postInstall = ''
      installShellCompletion --cmd ironbar \
        --bash target/completions/ironbar.bash \
        --fish target/completions/ironbar.fish \
        --zsh target/completions/_ironbar
    '';

    passthru = {
      updateScript = gnome.updateScript {
        packageName = pname;
        attrPath = "gnome.${pname}";
      };
    };

    meta = with lib; {
      homepage = "https://github.com/JakeStanger/ironbar";
      description = "Customisable gtk-layer-shell wlroots/sway bar written in rust.";
      license = licenses.mit;
      platforms = platforms.linux;
      mainProgram = "ironbar";
    };
  };

  flags = let
    noDefault =
      if features == []
      then ""
      else "--no-default-features";

    featuresStr =
      if features == []
      then ""
      else ''-F "${builtins.concatStringsSep "," features}"'';
  in [noDefault featuresStr];
in
  if builderName == "naersk"
  then builder.buildPackage (basePkg // {cargoBuildOptions = old: old ++ flags;})
  else if builderName == "crane"
  then
    builder.buildPackage (basePkg
      // {
        cargoExtraArgs = builtins.concatStringsSep " " flags;
        doCheck = false;
      })
  else
    rustPlatform.buildRustPackage (basePkg
      // {
        buildNoDefaultFeatures = features != [];

        buildFeatures = features;
        cargoDeps = rustPlatform.importCargoLock {lockFile = ../Cargo.lock;};
        cargoLock.lockFile = ../Cargo.lock;
        cargoLock.outputHashes."stray-0.1.3" = "sha256-7mvsWZFmPWti9AiX67h6ZlWiVVRZRWIxq3pVaviOUtc=";
      })
