# Parameter descriptions
## `Segment Count`
How many physically simulated segments the appendage should have.

**🔴Keep this number as low as possible🔴**, if you need the appendage to be longer or look smoother, use the `Segment Length` and `Subdivision` parameters instead of increasing this number.

## `Segment Length`
How long each physically simulated segment should be.

Increase this number to increase the overall length of the tail.

## `Curvature`
How much the entire appendage should curve.

Positive numbers will make the appendage curve clockwise.

Negative numbers will make the appendage curve counter-clockwise.

## `Curvature Exponent`
How much the end of the appendage should curl.

Positive numbers will curl the end of the appendage.

Negative numbers will straighten the end of the appendage.

A value of 0 will have no effect.

Unless `Curvature` is close to zero, this value should be itself close to zero (you'd rarely want it to be above 1, sometimes even 1 is too big).

## `Max Angle Degrees`
The maximum angle each physically simulated segment can bend.

A value of 180 or more will remove any restrictions on much segments can bend.

## `Comeback Speed`
How big of an impulse should be applied to segments when they reach the maximum bend angle to push them back towards being straight.

A value of 0 won't apply any impulses.

If `Max Angle Degrees` is set to 180 or more, this parameter will do nothing.

Increase this number if you want the appendage to react faster to sudden changes.

## `Stiffness`
How stiff the appendage should be.

This controls how fast the appendage will bend in the way specified by `Curvature` and `Curvature Exponent`

If this value is set to zero, the appendage won't try to bend in the aforementioned way at all (but `Curvature` and `Curvature Exponent` won't be ignored, as they affect `Max Angle Degrees`).

## `Stiffness Decay`
How much the stiffness should be reduced towards the end of the appendage.

This value shouldn't be higher than `Stiffness`, it shouldn't even be close.

Negative numbers will make the end of the appendage more stiff.

If `Stiffness` is 0, this parameter will do nothing, unless it's set to a negative number.

## `Stiffness Decay Exponent`
A parameter to further control the stiffness decay.

Values above 1 will make the decay more sudden and noticeable.

A value of 1 will do nothing.

Values below 1 will make the decay more gradual and subtle.

A value of 0 will (almost) negate the effects of `Stiffness Decay`.

Values below 0 will reverse the effects of `Stiffness Decay`.

(Values at or below 0 are not recommended)

## `Gravity`
A vector to determine the direction and strength of gravity.

## `Damping`
How fast the appendage stops wiggling.

Increase this value if the appendage is wiggling too much.

## `Max Angular Momentum`
How fast the appendage is allowed to spin.

The default value is good for most cases, you shouldn't need to change it.

## `Subdivision`
Hou much the physically simulated segments should be subdivided before rendering to achieve a smoother look.

The higher this value is, the higher the performance cost subdivision will have.

A value of 0 will disable subdividing.

Don't set this parameter to 1, it looks worse than having it at 0 while still having a performance cost.

## `Additional Start Segment`
If true, adds a small segment at the start of the appendage to bridge any gaps between it and the object it's supposed to look connected to.

## `Additional Start Segment Length`
The length of the segment added by `Additional Start Segment`.

## `Subdivide Additional Start Segment`
Whether or not to apply `Subdivision` to the segment added by `Additional Start Segment`.

## `Only Process When Visible`
If true, the appendge will only be processed when it and all it's parent nodes aren't hidden.

# Precise definitions
If you want a more precise and mathematical decription of what all these parameters do, see [Member variables and functions](../docs/member_variables_and_functions.md).


Overview & definitions
An appendage is made out of a small amount of physically simulated points, which from now on I’ll simply call points. The first of these points I call the root point, its location is always the global position of the appendage node.

The rotation of each point is considered to be the angle of the vector from its previous point to itself (the rotation of the root point is the global rotation of the appendage node). The target rotation of each point is the rotation it "wants to" be at.

The array of points is subdivided and smoothed before being set as the points for the Line2D class the appendages inherit from (this step is skipped if subdivision is 0).

Member variables
int segment_count
The amount of points the appendage will have. This doesn't count the root node, so the size of physics_points is segment_count + 1.

Setting this variable will call the reset() function.

float segment_length
The distance each point will be from its previous point (in pixels).

float curvature
The target rotation of each point relative to its previous point (in radians).

float curvature_exponent
A value that affects the target rotation of each point.

The target rotation of each point is calculated using the following formula:

Target rotation = Rotation of previous point + [curvature] * Index ^ [curvature_exponent]
(Index is a number that starts at 0 for the root point and increases by 1 for every consecutive point)

float max_angle_degrees
max_angle in degrees instead of radians.

float max_angle
How far the rotation of each point it allowed to deviate from its target rotation (in radians).

If this value is >= TAU / 2, all points will be able to rotate freely. *

* The effects of stiffness still apply.

float comeback_speed
If a point's rotation reaches its max_angle, its angular momentum (in radians/sec) will be set to this value going towards its target rotation. *

* If a point is already moving towards its target rotation faster than comeback_speed, it's angular momentum will be left unchanged.

float stiffness
What rotational force (in radians/sec^2) should be applied to each point to move it towards its target rotation

float stiffness_decay
A value that controls the stiffness for each individual point.

to see how exactly it does so, see stiffness_decay_exponent.

float stiffness_decay_exponent
A value that controls the stiffness for each individual point.

The stiffness for each individual point is calculated suing the following formula:

Point Stiffness = [stiffness] - Index ^ [stiffness_decay_exponent] * [stiffness_decay]
(Index is a number that starts at 0 for the root point and increases by 1 for every consecutive point)

Vector2 gravity
All points have a rotational force (in radians/sec^2) that simulates gravity acting on them.

This is the formula used to calculate said force:

Rotational force = Length(gravity) * cos(point_rotation - Angle(gravity) + TAU / 4)
(Length() and Angle() are self-explanatory functions)

(I don't know if this formula is correct, but it works well enough)

float damping
If a point is rotating away form it's target rotation, all forces acting on it (including gravity) will get multiplied by this value.

float max_angular_momentum
The maximum speed (in radians/sec) each point is allowed to rotate at.

int subdivision
How much subdivision to apply to the points before rendering them as a line.

To know how much subdivision will increase the amount of points, use the following formula:

Amount of points after subdivision = ceil((Amount of points before subdivision - 0.5) * [subdivision])
if [subdivision] is even, Amount of points after subdivision += 1
It's also worth noted that the subdivision algorithm doesn't necessarily produce evenly spaced-out points.

If subdivision is 0, the subdivision step will be skipped entirely.

subdivision should never be 1, it won't increase the amount of points and it looks worse than having subdivision at 0 while still having a performance impact.

bool additional_start_segment
If true, adds Vector2(-additional_start_segment_length, 0) to the start of the points array of Line2D.

float additional_start_segment_length
See additional_start_segment.

bool subdivide_additional_start_segment
If true, the additional_start_segment will be added before the subdivision step, else, it will be added afterwards.

bool only_process_when_visible
If true, is_visible_in_tree() will be called at the beginning of every process loop and if it returns true, the process loop will be skipped.

Array physics_points
An array that contains all the information about the physically simulated points.

This array is what is used internally to process the points.

🔴This is not an array of vectors🔴, instead, it's an array of arrays.

Each sub array contains the following information at these indexes:

Reference to the previous point array
Global position of the point
Global rotation of the point
Global angular momentum of the point (in radians/sec^2)
You shouldn't need to access this variable, if you want the positions of all physically simulated points, consider using get_global_point_positions().

Member functions
void reset(int point_count = segment_count + 1)
Removes all points from physics_points and adds back the amount specified by point_count.

Call this function if you want to reset the position and momentum of all points.

You should never specify the point_count parameter, it should always be at its default value.

PoolVector2Array get_global_point_positions()
Returns an array of the global positions of all points in physics_points.
