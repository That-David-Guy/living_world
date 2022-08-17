const cell_colors = {
      "deep-sea": 'rgb(30 64 175)',
      "sea": 'rgb(59 130 246)',
      "sand": 'rgb(253 230 138)',
      "grass": 'rgb(74 222 128)',
      "trees": 'rgb(22 163 74)',
      "mountain": 'rgb(148 163 184)',
      "snow": 'rgb(255 255 255)'
}

class MapCanvas {
    constructor(canvas, width, height, onEventFromMapCanvas) {
        this.canvas = canvas
        this.context = canvas.getContext("2d")
        this.width = width
        this.height = height
        this.onEventFromMapCanvas = onEventFromMapCanvas

        // TODO Handle if these are not set
        const payload = {
            worldId: parseInt(this.canvas.dataset.worldId),
            seed: parseInt(this.canvas.dataset.seed)
        }
        const origin_id = parseInt(this.canvas.dataset.worldId)
        this.onEventFromMapCanvas("request_data", origin_id, payload)

        // TEST:
    }

    // TODO: We are not utilising the seed yet
    initMapData(data) {
        const cell_width = 4
        const cell_height = 4

        for (let i=0; i< data.landmass.length; i++) {
            const cell = data.landmass[i]
            const actual_x = cell.screen_x * cell_width 
            const actual_y = cell.screen_y * cell_height
            this.context.fillStyle = cell_colors[cell.land_type];
            this.context.fillRect(actual_x, actual_y, cell_width, cell_height);
        }
    }
}


export {
    MapCanvas
}