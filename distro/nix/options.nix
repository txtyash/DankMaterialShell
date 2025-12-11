{
  lib,
  dmsPkgs,
  ...
}:
let
  inherit (lib) types;
  path = [
    "programs"
    "dankMaterialShell"
  ];

  builtInRemovedMsg = "This is now built-in in DMS and doesn't need additional dependencies.";
in
{
  imports = [
    (lib.mkRemovedOptionModule (path ++ [ "enableBrightnessControl" ]) builtInRemovedMsg)
    (lib.mkRemovedOptionModule (path ++ [ "enableColorPicker" ]) builtInRemovedMsg)
    (lib.mkRemovedOptionModule (
      path ++ [ "enableSystemSound" ]
    ) "qtmultimedia is now included on dms-shell package.")
  ];

  options.programs.dankMaterialShell = {
    enable = lib.mkEnableOption "DankMaterialShell";
    systemd = {
      enable = lib.mkEnableOption "DankMaterialShell systemd startup";
      restartIfChanged = lib.mkOption {
        type = types.bool;
        default = true;
        description = "Auto-restart dms.service when dankMaterialShell changes";
      };
    };
    enableSystemMonitoring = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Add needed dependencies to use system monitoring widgets";
    };
    enableClipboard = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Add needed dependencies to use the clipboard widget";
    };
    enableVPN = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Add needed dependencies to use the VPN widget";
    };
    enableDynamicTheming = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Add needed dependencies to have dynamic theming support";
    };
    enableAudioWavelength = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Add needed dependencies to have audio wavelength support";
    };
    enableCalendarEvents = lib.mkOption {
      type = types.bool;
      default = true;
      description = "Add calendar events support via khal";
    };
    quickshell = {
      package = lib.mkPackageOption dmsPkgs "quickshell" {
        extraDescription = "The quickshell package to use (defaults to be built from source, in the commit 26531f due to unreleased features used by DMS).";
      };
    };
  };
}
