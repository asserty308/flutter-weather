# flutter-weather
A weather app made with flutter

The app is under active development.

## Steps to build the app:
### API
1. Get an API key from OpenWeatherMap
2. Create a project for your app on Google API console
3. Activate timezone and places API in google api console
4. Create the file *secrets.json* in the top level directory of this project
````json
{
  "google_api_key":"paste_your_key_here",
  "owm_api_key":"paste_your_key_here"
}
````

### Assets
For now, assets are not included. I might add them in the future but by then you have to add your own assets in your *images/* directory.
The images you need are:
  + app_icon.png
  + clouds.png
  + fog.png
  + rain.png
  + rain_wind.png
  + snow.png
  + sun.png
  + sun_cloud_rain.png
  + sun_clouds.png
  + thunder_lightning.png
  + wind.png