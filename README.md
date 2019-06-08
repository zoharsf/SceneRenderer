# SceneRenderer

## Renders a scene using different shapes

### The program can use a number of inputs:
* Video streamed from the camera
* A loaded video
* A loaded image 

### The file has a list of toggles which can be flipped in order to change the effect used, the source of the scene and general configurations:

#### Effects:
* useCircles: render the scene using circles.
* useRings: render the scene using rings.
* useTriangles: render the scene using triangles.

#### Sources:
* useCam: use camera to render the scene.
* useMovie: use video to render the scene.
* useImage: use image to render the scene.

#### Configurations:
* useSlider: add a slider which controls the number of rendering objects per frame.
* saveImage: save the rendered scene to a file every 1 second. 
* drawScene: draw the scene. If false, the program will log the available camera resolutions to the console.

### Examples:
* Circles:
![Circles](circles.jpg?raw=true "Circles")
* Rings:
![Rings](rings.jpg?raw=true "Rings")
* Triangles:
![Triangles](triangles.jpg?raw=true "Triangles")
