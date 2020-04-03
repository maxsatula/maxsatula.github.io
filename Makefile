all: html commit

html:
	cd org && emacs --quick --batch --load=../project.el --funcall=org-publish-all

commit:
	git add --all org
	git commit --message="$(MESSAGE)"
	cd html && git add --all .
	cd html && git commit --message="$(MESSAGE)"

.PHONY: all html
