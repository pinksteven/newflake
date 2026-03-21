{
  # hm doesn't have a noption for this yet so this will have to do for now
  xdg.configFile."yazi/vfs.toml".text = ''
    [services.kaermorhen]
    type = "sftp"
    host = "kaermorhen"
    user = "steven"
    port = 22
  '';
}
