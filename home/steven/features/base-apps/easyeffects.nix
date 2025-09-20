{
  services.easyeffects = {
    enable = true;
  };

  # Most presets out there aren't actually in the easyeffects .json format
  # it's just easier to do this manually using gui on machine
  home.persistence."/persist" = {
    directories = [
      ".config/easyeffects"
    ];
  };
}
