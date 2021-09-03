# Git
> Git stuff to remember

- [Git](#git)
	- [Stash](#stash)
	- [History](#history)
		- [Go Back in time](#go-back-in-time)
	- [Reset](#reset)
		- [Reset in Remote](#reset-in-remote)
		- [Using Revert](#using-revert)
	- [Merge](#merge)
		- [Merge Branch into another](#merge-branch-into-another)
## Stash
Save changes into stash.
Remove local changes and save them into stash:
```
git stash
```
Get changes back:
```
git stash pop
```
## History
Each commit has a Hash. 

### Go Back in time
Get into a detached head state using git checkout
```
git checkout <hash>
```
To go back just use the checkout again.  

## Reset

### Reset in Remote
First reset locally:
```
git reset --hard 
```
Then overwrite the remote repository with the current version
```
git push --force
```

### Using Revert
Pushs a commit that has the reverse changes of the commit you want to undo
Revert using commit hash:
```
git revert <hash>
```
## Merge
### Merge Branch into another
Checkout into feature branch. And pull the Master commit into it.
After that you can push. To This locally when you want to update your current feature branch 
```
git merge master
```
