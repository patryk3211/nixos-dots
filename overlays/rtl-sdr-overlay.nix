(final: prev: rec {
  rtl-sdr-blog = final.stdenv.mkDerivation {
    pname = "rtl-sdr-blog-driver";
    version = "1.3.5";

    system = "x86_64-linux";

    src = fetchGit {
      url = "https://github.com/rtlsdrblog/rtl-sdr-blog";
      rev = "065e3d1a116f24c78622fd21c6c0d6efec35060b";
    };

    nativeBuildInputs = with final; [ pkg-config cmake ];
    buildInputs = with final; [
      libusb1
    ];

    cmakeFlags = [
      "-DINSTALL_UDEV_RULES=OFF"
    ];

    buildPhase = ''
      # Copy over the udev rules file
      mkdir -p $out/lib/udev/rules.d/
      cp $src/rtl-sdr.rules $out/lib/udev/rules.d/69-rtl-sdr.rules
    '';
  };
  rtl-sdr = rtl-sdr-blog;
  rtl-sdr-osmocom = rtl-sdr-blog;
})
#  rtl-sdr-blog
/*{
  environment.systemPackages = [ rtl-sdr-blog ];
  services.udev.packages = [ rtl-sdr-blog ];
}*/
