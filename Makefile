all: html commit

html:
	cd org && emacs --quick --batch --load=../project.el --funcall=org-publish-all

commit:
	cd html && git add --all .
	cd html && git commit --message="$(MESSAGE)"
	git add --all org html
	git commit --message="$(MESSAGE)"

push:
	git push
	cd html && git push

.PHONY: all html commit push
