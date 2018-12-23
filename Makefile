all: mwe-singularity-checkpoint.simg

count.out: count.c
	c++ count.c -o count.out

mwe-singularity-checkpoint.simg: Singularity
	sudo singularity build mwe-singularity-checkpoint.simg Singularity

demonstrate: mwe-singularity-checkpoint.simg
	./mwe-singularity-checkpoint.simg

test: mwe-singularity-checkpoint.simg
	yes | ./mwe-singularity-checkpoint.simg

shub:
	singularity pull --name mwe-singularity-checkpoint.simg shub://mmore500/mwe-singularity-checkpoint

clean:
	rm -f mwe-singularity-checkpoint.simg count.out ckpt_status count_status *.dmtcp dmtcp_restart_script*

.PHONY: clean send test demonstrate shub
