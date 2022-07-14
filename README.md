# material_scrollbar

<a href="https://pub.dev/packages/material_scrollbar">
<img src="https://img.shields.io/pub/v/material_scrollbar?label=material_scrollbar&style=for-the-badge" alt="material_scrollbar version">
</a>
<a href="https://github.com/hamiranisahil/material_scrollbar/stargazers">
<img src="https://img.shields.io/github/stars/hamiranisahil/material_scrollbar?style=for-the-badge" alt="material_scrollbar Git Stars">
</a>
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white">
</a>
<a href="https://developer.android.com" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/website-000000?style=for-the-badge&logo=About.me&logoColor=white">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white">
</a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg?style=for-the-badge" alt="MIT License"></a>

This package provides customizable scrollbar for your widget and easy to implement with the few lines of code.


### Material Scrollbar.
![Material Scrollbar](https://github.com/hamiranisahil/material_scrollbar/blob/main/assets/material_scrollbar.gif)


## Usage

### Example
    MaterialScrollBar(
            thumbColor: const Color(0xffe240fb),
            trackColor: const Color(0xfff0c0f8),
            thumbVisibility: true,
            thickness: 10,
            radius: const Radius.circular(10),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        title: Text(items[index]),
                      ),
                      const Divider(
                        height: 1,
                      )
                    ],
                  ),
                );
              },
              itemCount: items.length,
            ),
          );

### Required parameters

##### thumbColor:
thumbColor is the moving part of the scrollbar, which usually floats on top of the track.

##### trackColor:
trackColor is the empty space “below” the progress bar.


### Optional parameters

##### thickness:
The thickness of the scrollbar in the cross axis of the scrollable.

##### thumbVisibility:
Indicates that the scrollbar thumb should be visible, even when a scroll is not underway.

##### radius:
The Radius of the scrollbar thumb's rounded rectangle corners.

##### thumbSize:
The size of the scrollbar thumb.


## Guideline for contributors
Contribution towards our repository is always welcome, we request contributors to create a pull request to the develop branch only.


## Guideline to report an issue/feature request
It would be great for us if the reporter can share the below things to understand the root cause of the issue.
- Library version
- Code snippet
- Logs if applicable
- Device specification like (Manufacturer, OS version, etc)
- Screenshot/video with steps to reproduce the issue


# LICENSE!
Material Scrollbar is [MIT-licensed](https://github.com/hamiranisahil/material_scrollbar/blob/main/LICENSE "MIT-licensed").


# Let us know!
We’d be really happy if you send us links to your projects where you use our component. Just send an email to hamirani.sahil@gmail.com And do let us know if you have any questions or suggestion regarding our work.
