class ChunkRenderer {
	
	constructor(shader) {
		this.shader = new ChunkShader();
	}
	
	render() {
		if(this.shader.program) {
			this.shader.start();
			
			this.shader.loadAtmosphere(render_distance, skycolour);
		    this.shader.loadProjection(projection);
		    this.shader.loadView(view);
		    
		    let distance = 1;
		    
		    for(let celestial of celestials.values()) {
		    	for(let chunk of celestial.chunks.values()) {
		    		this.draw(chunk);
		    	}
		    }
			this.shader.stop();
		}
	}
	
	draw(chunk) {
		if(chunk.model) {
			this.shader.loadTransformation(Maths.createTransformationMatrix(chunk.celestial.origin, chunk.celestial.rotation, new Vector3(1.0, 1.0, 1.0)));
			
			gl.bindVertexArray(chunk.model.x);
			gl.enableVertexAttribArray(0);
		    
		    gl.drawElements(gl.TRIANGLES, chunk.model.y, gl.UNSIGNED_SHORT, 0);
		    
		    gl.disableVertexAttribArray(0);
		    gl.bindVertexArray(null);
		}
	}
}