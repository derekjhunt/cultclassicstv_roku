' *********************************************************
' ** CultClassics.TV
' *********************************************************

Sub Main()
    print "Displaying video: "
    p = CreateObject("roMessagePort")
    video = CreateObject("roVideoScreen")
    video.setMessagePort(p)

    videoclip = CreateObject("roAssociativeArray")
    videoclip.StreamBitrates = [0]

' *********************************************************
' ** HLS
' *********************************************************
    videoclip.StreamUrls = ["https://cultclassics.tv:5080/LiveApp/streams/556336427398358095038757.m3u8"]

    di = CreateObject("roDeviceInfo")
    if di.GetDisplayType() = "HDTV" then
     videoclip.streamqualities=["HD"]
    else
     videoclip.streamqualities=["SD"]
    end if

' *********************************************************
' ** Modify the info according to your channel name
' *********************************************************
    videoclip.StreamFormat = "hls"
    videoclip.Title = "CultClassics.TV"
    videoclip.SubtitleUrl = "Underground TV for the Infected."
    videoclip.switchingstrategy="full-adaptation"

    video.SetContent(videoclip)
    video.show()

    lastSavedPos   = 0
    statusInterval = 10

    while true
        msg = wait(0, video.GetMessagePort())
        if type(msg) = "roVideoScreenEvent"
            if msg.isScreenClosed() then 'ScreenClosed event
                print "Closing video screen"
                return
                exit while
            else if msg.isPlaybackPosition() then
                nowpos = msg.GetIndex()
                if nowpos > 10000

                end if
                if nowpos > 0
                    if abs(nowpos - lastSavedPos) > statusInterval
                        lastSavedPos = nowpos
                    end if
                end if
            else if msg.isRequestFailed()
                print "play failed: "; msg.GetMessage()
            else
                print "Unknown event: "; msg.GetType(); " msg: "; msg.GetMessage()
            endif
        end if
    end while
end Sub
