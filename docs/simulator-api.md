# Browser Simulator API

The browser application lives at [`docs/simulator/index.html`](simulator/index.html) and is published at [Mission Control](simulator/index.html) on the GitHub Pages site. It is a client-side educational simulation; it does not make HTTP requests to a spacecraft or backend server.

## JavaScript interface

After the page loads, the app exposes `window.SatelliteSim`.

| Method | Purpose |
|---|---|
| `SatelliteSim.listSatellites()` | Returns a snapshot of registered spacecraft and orbital configuration. |
| `SatelliteSim.getTelemetry(id?)` | Returns telemetry for the specified ID, or the selected satellite if omitted. Returns `null` for an unknown ID. |
| `SatelliteSim.setOrbit(id, params)` | Applies supported orbit parameters and returns updated telemetry. |
| `SatelliteSim.command(type, id?)` | Simulates a local command and returns the resulting telemetry snapshot. |
| `SatelliteSim.pause()` / `resume()` | Pauses or resumes the simulation clock. |
| `SatelliteSim.advance(seconds)` | Advances simulated time by a non-negative number of seconds. |

The display controls also provide a CRT-style presentation with optional scanlines and cyan, green, amber, or blue phosphor tint. Brightness and display profile preferences are stored in browser `localStorage` when available. Use the **Export telemetry JSON** or **Export telemetry CSV** buttons to download a snapshot for every registered satellite; exports are generated locally and are not uploaded.

### Orbit parameter names

```js
SatelliteSim.setOrbit("SAT-001", {
  altitudeKm: 550,
  inclinationDeg: 51.6,
  eccentricity: 0.001,
  raanDeg: 35,
  phaseDeg: 20
});
```

### Telemetry example

```js
const telemetry = SatelliteSim.getTelemetry("SAT-001");
console.log(telemetry.altitudeKm, telemetry.velocityKmS);
```

Telemetry includes latitude and longitude, altitude, radial distance, speed, orbital period, range and elevation relative to the configured ground station, station visibility, and safe-mode state.

## Model and limitations

- The orbit model uses the two-body gravitational parameter for Earth and a Kepler-equation solution.
- Earth rotation and a spherical ground-station visibility model are approximated for visualization and education.
- The ground-track display is an illustrative equirectangular plot, not a precision ephemeris.
- The visual Earth and orbit drawing are schematic and not a rendering of current satellite positions.
- Command acknowledgements are local simulated events. No radio link, server persistence, authentication, or live spacecraft interface is implemented by this static web app.
- The altitude slider is constrained to 160–36,000 km; eccentricity is constrained to 0–0.75 for the UI.
- The simulator is not flight-qualified software and must not be used for operational spacecraft decisions.

The Pages build runs `python tools/web-simulator-tests/check.py` before building the documentation. It checks required controls, duplicate HTML IDs, the public API presence, and JavaScript syntax using Node.js.

For the native C++ project and build instructions, see [Build and Run](build.md) and the [API design reference](api-reference.md).
