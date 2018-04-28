.RECIPEPREFIX += 

sandbox : Singularity
       sudo singularity build sandbox Singularity

clean :
       rm sandbox
