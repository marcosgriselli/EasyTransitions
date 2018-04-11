<img src="https://cdn.rawgit.com/marcosgriselli/EasyTransitions/d0d5b005/Resources/banner.svg" width=100%/>

**EasyTransitions** is a library that helps developers create custom interactive transitions using simple functions defined in a protocol and avoid handling with the mutiple transitions API's in UIKit.

[![Version](https://img.shields.io/cocoapods/v/EasyTransitions.svg?style=flat)](http://cocoapods.org/pods/Transitions)
![iOS 8+](https://img.shields.io/badge/iOS-10%2B-blue.svg?style=flat)
![Swift 4](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)
[![codebeat badge](https://codebeat.co/badges/633fb33d-66b6-4034-93c0-0f52c5d0e15c)](https://codebeat.co/projects/github-com-marcosgriselli-easytransitions-master)

## ⚠️ This library is a work in progress (WIP) expect many changes until it reaches 1.0 ⚠️

The development roadmap will be documented using Github issues, milestons and project. Contributions are welcome! 

## Transitions

Given that `UIViewControllerAnimatedTransitioning` works differently for Modal presentations and `UINavigationController` transitions I've split the functionality in: 

* `ModalTransitionConfigurator`
* `NavigationTransitionConfigurator`

Each of them grabs the available views to perfrom the transition. As read in the docs I avoid grabbing the views directly from the `UIViewControllers` and access them via `UIViewControllerContextTransitioning`'s `view(forKey: UITransitionContextViewKey)`. 

### Modal Transitions
<img src="https://cdn.rawgit.com/marcosgriselli/EasyTransitions/40b7070b/app_store_short.gif" width="200px"/>

```swift 
public protocol ModalTransitionAnimator {
    var duration: TimeInterval { get }
    var onDismissed: () -> Void { get set }
    func layout(presenting: Bool,
                modalView: UIView,
                in container: UIView)
    func animate(presenting: Bool,
                 modalView: UIView,
                 in container: UIView) 
}
```

During a modal transition we should only manage the view that is being presented modaly (modalView). We can inject animations on the root controller anyway.

The `ModalTransitionAnimator` is a really straight forward protocol. Just layout the views ready to be animated on `layout` function and perform the animations on `animate`. You can check the [AppStoreAnimator](https://github.com/marcosgriselli/EasyTransitions/blob/master/EasyTransitions/Classes/Animators/AppStoreAnimator.swift) for a basic example. 

### UINavigationController Transitions
<img src="https://cdn.rawgit.com/marcosgriselli/EasyTransitions/d0d5b005/Resources/Gifs/navigation.gif" width="200px"/>

`UINavigationController` have a slightly different approach. Both the _from_ and _to_ view are accessible using `view(forKey: UITransitionContextViewKey)` so we add them to the protocol functions. 

```swift 
public protocol NavigationTransitionAnimator {
    var duration: TimeInterval { get }
    var auxAnimations: (Bool) -> [AuxAnimation] { get set }
    func layout(presenting: Bool, fromView: UIView,
                toView: UIView, in container: UIView)
    func animations(presenting: Bool,
                    fromView: UIView, toView: UIView,
                    in container: UIView)
}
```

I've added the auxiliary animations as part of the protocol but expect multiple changes in this area. 

## Interaction

`TransitionInteractiveController` handles wiring a `UIPanGestureRecognizer` to the current `UIViewController`. This works for any action as we should set the `navigationAction: () -> Void` for the interaction to work. This let's us use the same `TransitionInteractiveController` class for Modal, `UINavigationController` or even `UITabBarController` transitions. 

It's wiring takes a `UIViewController` and a `Pan` object. EasyTransitions handles the swiping automatically. It responds to velocity and completness percentage to finish the transition. I plan to support configuring this. 

Right now the transition will complete if we stop swiping when it's over 50% or if we swipe fast or release. It will cancel it self if we swipe fast and release in the oposite direction.

### Pan 

The `Pan` enum is a simple way to unify `UIPanGestureRecognizer` and `UIScreenEdgePanGestureRecognizer`. Internally EasyTransitions uses `TransitionPanGestureRecognizer` and `TransitionEdgePanGestureRecognier` to support a `PanGesture` protocol which calculates velocity and translation for each gesture and the correct sign they should have. 

```swift 
public enum Pan {
    case regular(PanDirection)
    case edge(UIRectEdge)
}
```

## Usage 

There's an example on `TodayCollectionViewController` but there should't be many changes on other implementations. Here's a generic example: 

```swift 
class MainViewController: UIViewController {
var transitionDelegate = ModalTransitionDelegate()

func showDetailViewController() {
	let detailController = DetailViewController()
	let animator = MyAnimator() // ModalTransitionAnimator
	modalTransitionDelegate.set(animator: animator)
	modalTransitionDelegate.wire(viewController: detailController,
                            	  with: .regular(.fromTop))
        
	detailController.transitioningDelegate = modalTransitionDelegate
	detailController.modalPresentationStyle = .custom
        
	present(detailController, animated: true, completion: nil)
}
```

## Project Details

### Requirements
* Swift 4.0
* Xcode 9.0+
* iOS 10.0+

### Contributing
Feel free to collaborate with ideas 💭, issues ⁉️ and/or pull requests 🔃.

If you use ViewAnimator in your app I'd love to hear about it and feature your animation here!

### Author

Marcos Griselli | <a href="url"><img src="https://cdn.rawgit.com/marcosgriselli/ViewAnimator/cf065e96/Resources/twitterLogo.svg" height="17"></a> [@marcosgriselli](https://twitter.com/marcosgriselli)


[![Twitter Follow](https://img.shields.io/twitter/follow/marcosgriselli.svg?style=social)](https://twitter.com/marcosgriselli)

### License

> Copyright (c) 2017 Marcos Griselli

> Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

> The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

