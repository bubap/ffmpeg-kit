Pod::Spec.new do |s|
    s.name              = "ffmpeg-kit-ios-bubap"
    s.version           = "0.0.2"
    s.summary           = "FFmpeg Kit iOS Full Static Framework"
    s.description       = <<-DESC
    FFmpeg Kit iOS Full Static Framework For bubagump
    DESC

    s.homepage          = "https://github.com/bubap/ffmpeg-kit"

    s.author            = { "scvgoe" => "scvgoe@bubagump.net" }
    s.license           = { :type => "LGPL-3.0", :file => "ffmpegkit.xcframework/ios-arm64/ffmpegkit.framework/LICENSE" }

    s.platform          = :ios
    s.requires_arc      = true
    s.libraries         = 'z', 'bz2', 'c++', 'iconv'

    s.source            = { :http => "https://github.com/bubap/ffmpeg-kit/releases/download/0.0.2-alpha/ffmpeg-kit-bubap-0.0.2-ios-xcframework.zip" }

    s.ios.deployment_target = '12.1'
    s.ios.frameworks    = 'AudioToolbox','AVFoundation','CoreMedia','VideoToolbox'
    s.ios.vendored_frameworks = 'ffmpegkit.xcframework', 'libavcodec.xcframework', 'libavdevice.xcframework', 'libavfilter.xcframework', 'libavformat.xcframework', 'libavutil.xcframework', 'libswresample.xcframework', 'libswscale.xcframework', 'dav1d.xcframework', 'expat.xcframework', 'fontconfig.xcframework', 'freetype.xcframework', 'fribidi.xcframework', 'giflib.xcframework', 'gmp.xcframework', 'gnutls.xcframework', 'harfbuzz.xcframework', 'jpeg.xcframework', 'kvazaar.xcframework', 'lame.xcframework', 'libass.xcframework', 'libhogweed.xcframework', 'libilbc.xcframework', 'libnettle.xcframework', 'libogg.xcframework', 'libopencore-amrnb.xcframework', 'libpng.xcframework', 'libsndfile.xcframework', 'libtheora.xcframework', 'libtheoradec.xcframework', 'libtheoraenc.xcframework', 'libvorbis.xcframework', 'libvorbisenc.xcframework', 'libvorbisfile.xcframework', 'libvpx.xcframework', 'libwebp.xcframework', 'libwebpmux.xcframework', 'libwebpdemux.xcframework', 'libxml2.xcframework', 'opus.xcframework', 'shine.xcframework', 'snappy.xcframework', 'soxr.xcframework', 'speex.xcframework', 'tiff.xcframework', 'twolame.xcframework', 'vo-amrwbenc.xcframework', 'openh264.xcframework'

end
