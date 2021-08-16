dev="SynPS/2 Synaptics TouchPad"

xinput set-prop "$dev" "Synaptics Noise Cancellation" 20 20
xinput set-prop "$dev" "Synaptics Finger" 50 50 255
synclient PalmDetect=1
synclient PalmMinWidth=05
synclient TapButton1=0
synclient TapButton2=0
synclient TapButton3=0
synclient TapAndDragGesture=0
synclient VertEdgeScroll=0
synclient VertTwoFingerScroll=1
synclient VertScrollDelta=250
synclient HorizScrollDelta=250
xinput set-prop "$dev" "Coordinate Transformation Matrix" 1 0 0 0 1 0 0 0 100000
xinput --set-prop "$dev" "Synaptics Scrolling Distance" 350 350
