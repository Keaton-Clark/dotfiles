{pkgs, config, lib, ...}: {
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "${config.user}" ];
}
