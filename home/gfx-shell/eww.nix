{ config, ... }:

{
  patmods.eww = {
    enable = true;

    configDirectory = ./eww-conf;
  };
}
