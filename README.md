# 🍉 Funky Melon – Final Cut Pro Plugin Store (macOS / SwiftUI)

Welcome to **Funky Melon**, a sample macOS app for Final Cut Pro plug-ins.  
Browse 🎞 *Transitions*, ✨ *Effects*, and 🔤 *Titles*; install or update free items; manage your personal library; and explore rich details for each plug-in – all with modern SwiftUI patterns.



---

## ✨ Features

| UI / UX                                                          | Data & Logic                                                                                              |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| 🍏 **macOS 14+** native SwiftUI app               | 🔄 **PluginStore** – `@MainActor` observable object that loads JSON and handles install / update / uninstall |
| 🗂 **NavigationSplitView** sidebar with icons                     | ⏳ Concurrent multi-download simulation with per-item progress                                             |
| 🔍 Discover & category tabs with **search** and **segmented sort**| 🗃 JSON decoding helper `Bundle.loadPlugins()`                                                             |
| 🖼 Responsive **adaptive grids** (1-4 columns)                    | 🧹 Uninstall & version-bump helpers                                                                        |
| 🖱 Hover effects & gradient cards                                 |                                                                                                            |
| 🛑 Lottie-powered empty-state animation                           |                                                                                                            |

---

## 🛠 Requirements

* **Xcode 16** (beta or later)  
* **macOS 14** or newer  
* Swift 5.9 / SwiftUI 3  
* (Optional) **Lottie** 4.x via Swift Package Manager

---

## 🚀 Getting Started

```bash
git clone https://github.com/delrooow/FunkyMelon.git
cd FunkyMelon
open FunkyMelon.xcodeproj   # then ⌘R to run on “My Mac”
