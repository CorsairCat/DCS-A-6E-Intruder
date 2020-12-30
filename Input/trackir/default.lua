return {
axisCommands = {
-- TrackIR axes
{combos = {{key = 'TRACKIR_PITCH'}},	action = iHeadTrackerPitchNormed	, name = _('Head Tracker : Pitch')},
{combos = {{key = 'TRACKIR_YAW'}},  	action = iHeadTrackerYawNormed		, name = _('Head Tracker : Yaw')},
{combos = {{key = 'TRACKIR_ROLL'}}, 	action = iHeadTrackerRollNormed		, name = _('Head Tracker : Roll')},

{combos = {{key = 'TRACKIR_X'}}, 		action = iHeadTrackerPosZNormed		, name = _('Head Tracker : Right/Left')},
{combos = {{key = 'TRACKIR_Y'}}, 		action = iHeadTrackerPosYNormed		, name = _('Head Tracker : Up/Down')},
{combos = {{key = 'TRACKIR_Z'}}, 		action = iHeadTrackerPosXNormed		, name = _('Head Tracker : Forward/Backward')},

{action = iCommandViewVerticalAbs		, name = _('Absolute Camera Vertical View')},
{action = iCommandViewHorizontalAbs		, name = _('Absolute Camera Horizontal View')},
{action = iCommandViewHorTransAbs		, name = _('Absolute Horizontal Shift Camera View')},
{action = iCommandViewVertTransAbs		, name = _('Absolute Vertical Shift Camera View')},
{action = iCommandViewLongitudeTransAbs	, name = _('Absolute Longitude Shift Camera View')},
{action = iCommandViewRollAbs			, name = _('Absolute Roll Shift Camera View')},
{action = iCommandViewZoomAbs			, name = _('Zoom View')},
},
}
