; ModuleID = 'marshal_methods.arm64-v8a.ll'
source_filename = "marshal_methods.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [417 x ptr] zeroinitializer, align 8

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [834 x i64] [
	i64 17578172352203612, ; 0: Plugin.Firebase.Storage => 0x3e73412eda8b5c => 225
	i64 24362543149721218, ; 1: Xamarin.AndroidX.DynamicAnimation => 0x568d9a9a43a682 => 266
	i64 96808603140984794, ; 2: Google.Cloud.Location.dll => 0x157eee9616b8fda => 184
	i64 98382396393917666, ; 3: Microsoft.Extensions.Primitives.dll => 0x15d8644ad360ce2 => 201
	i64 120698629574877762, ; 4: Mono.Android => 0x1accec39cafe242 => 171
	i64 131669012237370309, ; 5: Microsoft.Maui.Essentials.dll => 0x1d3c844de55c3c5 => 210
	i64 196720943101637631, ; 6: System.Linq.Expressions.dll => 0x2bae4a7cd73f3ff => 58
	i64 210515253464952879, ; 7: Xamarin.AndroidX.Collection.dll => 0x2ebe681f694702f => 253
	i64 229794953483747371, ; 8: System.ValueTuple.dll => 0x330654aed93802b => 151
	i64 232391251801502327, ; 9: Xamarin.AndroidX.SavedState.dll => 0x3399e9cbc897277 => 294
	i64 295915112840604065, ; 10: Xamarin.AndroidX.SlidingPaneLayout => 0x41b4d3a3088a9a1 => 297
	i64 316157742385208084, ; 11: Xamarin.AndroidX.Core.Core.Ktx.dll => 0x46337caa7dc1b14 => 260
	i64 350667413455104241, ; 12: System.ServiceProcess.dll => 0x4ddd227954be8f1 => 132
	i64 422779754995088667, ; 13: System.IO.UnmanagedMemoryStream => 0x5de03f27ab57d1b => 56
	i64 435118502366263740, ; 14: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x609d9f8f8bdb9bc => 296
	i64 441196909651674427, ; 15: Xamarin.GooglePlayServices.Measurement.Sdk => 0x61f724073c9c53b => 360
	i64 454362216236841667, ; 16: Plugin.Firebase.Analytics => 0x64e38074227fac3 => 216
	i64 502670939551102150, ; 17: System.Management.dll => 0x6f9d88e66daf4c6 => 234
	i64 545109961164950392, ; 18: fi/Microsoft.Maui.Controls.resources.dll => 0x7909e9f1ec38b78 => 389
	i64 560278790331054453, ; 19: System.Reflection.Primitives => 0x7c6829760de3975 => 95
	i64 634308326490598313, ; 20: Xamarin.AndroidX.Lifecycle.Runtime.dll => 0x8cd840fee8b6ba9 => 279
	i64 649145001856603771, ; 21: System.Security.SecureString => 0x90239f09b62167b => 129
	i64 687654259221141486, ; 22: Xamarin.GooglePlayServices.Base => 0x98b09e7c92917ee => 353
	i64 702024105029695270, ; 23: System.Drawing.Common => 0x9be17343c0e7726 => 231
	i64 718159679911342543, ; 24: FirebaseAdmin.dll => 0x9f76a6c851fb1cf => 174
	i64 750875890346172408, ; 25: System.Threading.Thread => 0xa6ba5a4da7d1ff8 => 145
	i64 798450721097591769, ; 26: Xamarin.AndroidX.Collection.Ktx.dll => 0xb14aab351ad2bd9 => 254
	i64 799765834175365804, ; 27: System.ComponentModel.dll => 0xb1956c9f18442ac => 18
	i64 849051935479314978, ; 28: hi/Microsoft.Maui.Controls.resources.dll => 0xbc8703ca21a3a22 => 392
	i64 872800313462103108, ; 29: Xamarin.AndroidX.DrawerLayout => 0xc1ccf42c3c21c44 => 265
	i64 895210737996778430, ; 30: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 0xc6c6d6c5569cbbe => 280
	i64 940822596282819491, ; 31: System.Transactions => 0xd0e792aa81923a3 => 150
	i64 960778385402502048, ; 32: System.Runtime.Handles.dll => 0xd555ed9e1ca1ba0 => 104
	i64 1010599046655515943, ; 33: System.Reflection.Primitives.dll => 0xe065e7a82401d27 => 95
	i64 1055774368762298424, ; 34: ar/Microsoft.Maui.Controls.resources => 0xea6dd31d50a0038 => 382
	i64 1120440138749646132, ; 35: Xamarin.Google.Android.Material.dll => 0xf8c9a5eae431534 => 340
	i64 1121665720830085036, ; 36: nb/Microsoft.Maui.Controls.resources.dll => 0xf90f507becf47ac => 400
	i64 1155807931551632357, ; 37: Xamarin.Io.PerfMark.PerfMarkApi.dll => 0x100a4130a4b6cbe5 => 372
	i64 1213069524004690018, ; 38: Plugin.Firebase.DynamicLinks => 0x10d5b04e1226d862 => 221
	i64 1268860745194512059, ; 39: System.Drawing.dll => 0x119be62002c19ebb => 36
	i64 1274338068859211160, ; 40: Xamarin.Grpc.Api => 0x11af5bb8ce1c4d98 => 366
	i64 1301626418029409250, ; 41: System.Diagnostics.FileVersionInfo => 0x12104e54b4e833e2 => 28
	i64 1315114680217950157, ; 42: Xamarin.AndroidX.Arch.Core.Common.dll => 0x124039d5794ad7cd => 249
	i64 1368633735297491523, ; 43: Xamarin.Firebase.Database.Collection.dll => 0x12fe5d218405e243 => 320
	i64 1369545283391376210, ; 44: Xamarin.AndroidX.Navigation.Fragment.dll => 0x13019a2dd85acb52 => 287
	i64 1392315331768750440, ; 45: Xamarin.Firebase.Auth.Interop.dll => 0x13527f6add681168 => 315
	i64 1404195534211153682, ; 46: System.IO.FileSystem.Watcher.dll => 0x137cb4660bd87f12 => 50
	i64 1425944114962822056, ; 47: System.Runtime.Serialization.dll => 0x13c9f89e19eaf3a8 => 115
	i64 1465843056802068477, ; 48: Xamarin.Firebase.Components.dll => 0x1457b87e6928f7fd => 317
	i64 1474586420366808421, ; 49: Xamarin.Grpc.Android.dll => 0x1476c88960941565 => 365
	i64 1476839205573959279, ; 50: System.Net.Primitives.dll => 0x147ec96ece9b1e6f => 70
	i64 1486715745332614827, ; 51: Microsoft.Maui.Controls.dll => 0x14a1e017ea87d6ab => 207
	i64 1492954217099365037, ; 52: System.Net.HttpListener => 0x14b809f350210aad => 65
	i64 1513467482682125403, ; 53: Mono.Android.Runtime => 0x1500eaa8245f6c5b => 170
	i64 1537168428375924959, ; 54: System.Threading.Thread.dll => 0x15551e8a954ae0df => 145
	i64 1556147632182429976, ; 55: ko/Microsoft.Maui.Controls.resources.dll => 0x15988c06d24c8918 => 398
	i64 1576750169145655260, ; 56: Xamarin.AndroidX.Window.Extensions.Core.Core => 0x15e1bdecc376bfdc => 308
	i64 1624659445732251991, ; 57: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0x168bf32877da9957 => 248
	i64 1628611045998245443, ; 58: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0x1699fd1e1a00b643 => 283
	i64 1636321030536304333, ; 59: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 0x16b5614ec39e16cd => 273
	i64 1643226597988041431, ; 60: pl/Microsoft.Maui.Controls.resources => 0x16cde9e27a8d02d7 => 402
	i64 1651782184287836205, ; 61: System.Globalization.Calendars => 0x16ec4f2524cb982d => 40
	i64 1659332977923810219, ; 62: System.Reflection.DispatchProxy => 0x1707228d493d63ab => 89
	i64 1682513316613008342, ; 63: System.Net.dll => 0x17597cf276952bd6 => 81
	i64 1731380447121279447, ; 64: Newtonsoft.Json => 0x18071957e9b889d7 => 214
	i64 1735388228521408345, ; 65: System.Net.Mail.dll => 0x181556663c69b759 => 66
	i64 1743969030606105336, ; 66: System.Memory.dll => 0x1833d297e88f2af8 => 62
	i64 1767386781656293639, ; 67: System.Private.Uri.dll => 0x188704e9f5582107 => 86
	i64 1769105627832031750, ; 68: Google.Protobuf => 0x188d203205129a06 => 186
	i64 1795316252682057001, ; 69: Xamarin.AndroidX.AppCompat.dll => 0x18ea3e9eac997529 => 247
	i64 1825687700144851180, ; 70: System.Runtime.InteropServices.RuntimeInformation.dll => 0x1956254a55ef08ec => 106
	i64 1836611346387731153, ; 71: Xamarin.AndroidX.SavedState => 0x197cf449ebe482d1 => 294
	i64 1837131419302612636, ; 72: Xamarin.Google.Android.DataTransport.TransportBackendCct.dll => 0x197ecd4ad53dce9c => 338
	i64 1854145951182283680, ; 73: System.Runtime.CompilerServices.VisualC => 0x19bb3feb3df2e3a0 => 102
	i64 1865037103900624886, ; 74: Microsoft.Bcl.AsyncInterfaces => 0x19e1f15d56eb87f6 => 192
	i64 1875417405349196092, ; 75: System.Drawing.Primitives => 0x1a06d2319b6c713c => 35
	i64 1875917498431009007, ; 76: Xamarin.AndroidX.Annotation.dll => 0x1a08990699eb70ef => 244
	i64 1897575647115118287, ; 77: Xamarin.AndroidX.Security.SecurityCrypto => 0x1a558aff4cba86cf => 296
	i64 1920760634179481754, ; 78: Microsoft.Maui.Controls.Xaml => 0x1aa7e99ec2d2709a => 208
	i64 1956817255800234857, ; 79: Xamarin.Grpc.Android => 0x1b2802ed2e53e369 => 365
	i64 1959996714666907089, ; 80: tr/Microsoft.Maui.Controls.resources.dll => 0x1b334ea0a2a755d1 => 410
	i64 1972385128188460614, ; 81: System.Security.Cryptography.Algorithms => 0x1b5f51d2edefbe46 => 119
	i64 1981742497975770890, ; 82: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x1b80904d5c241f0a => 281
	i64 1982045842314265362, ; 83: Stripe.net => 0x1b81a43137ae8312 => 228
	i64 1983698669889758782, ; 84: cs/Microsoft.Maui.Controls.resources.dll => 0x1b87836e2031a63e => 384
	i64 1990714127648872464, ; 85: Xamarin.Grpc.Core.dll => 0x1ba06ff3abdcd810 => 368
	i64 2019660174692588140, ; 86: pl/Microsoft.Maui.Controls.resources.dll => 0x1c07463a6f8e1a6c => 402
	i64 2040001226662520565, ; 87: System.Threading.Tasks.Extensions.dll => 0x1c4f8a4ea894a6f5 => 142
	i64 2052224852812364517, ; 88: Plugin.Firebase.Firestore.dll => 0x1c7af7a1671bfae5 => 222
	i64 2062890601515140263, ; 89: System.Threading.Tasks.Dataflow => 0x1ca0dc1289cd44a7 => 141
	i64 2064708342624596306, ; 90: Xamarin.Kotlin.StdLib.Jdk7.dll => 0x1ca7514c5eecb152 => 377
	i64 2080945842184875448, ; 91: System.IO.MemoryMappedFiles => 0x1ce10137d8416db8 => 53
	i64 2102659300918482391, ; 92: System.Drawing.Primitives.dll => 0x1d2e257e6aead5d7 => 35
	i64 2106033277907880740, ; 93: System.Threading.Tasks.Dataflow.dll => 0x1d3a221ba6d9cb24 => 141
	i64 2133195048986300728, ; 94: Newtonsoft.Json.dll => 0x1d9aa1984b735138 => 214
	i64 2145898162032646099, ; 95: ko/Microsoft.Maui.Controls.resources => 0x1dc7c302481e97d3 => 398
	i64 2165310824878145998, ; 96: Xamarin.Android.Glide.GifDecoder => 0x1e0cbab9112b81ce => 241
	i64 2165725771938924357, ; 97: Xamarin.AndroidX.Browser => 0x1e0e341d75540745 => 251
	i64 2200176636225660136, ; 98: Microsoft.Extensions.Logging.Debug.dll => 0x1e8898fe5d5824e8 => 199
	i64 2262844636196693701, ; 99: Xamarin.AndroidX.DrawerLayout.dll => 0x1f673d352266e6c5 => 265
	i64 2287834202362508563, ; 100: System.Collections.Concurrent => 0x1fc00515e8ce7513 => 8
	i64 2287887973817120656, ; 101: System.ComponentModel.DataAnnotations.dll => 0x1fc035fd8d41f790 => 14
	i64 2302323944321350744, ; 102: ru/Microsoft.Maui.Controls.resources.dll => 0x1ff37f6ddb267c58 => 406
	i64 2304837677853103545, ; 103: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 0x1ffc6da80d5ed5b9 => 293
	i64 2315304989185124968, ; 104: System.IO.FileSystem.dll => 0x20219d9ee311aa68 => 51
	i64 2329709569556905518, ; 105: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x2054ca829b447e2e => 276
	i64 2335503487726329082, ; 106: System.Text.Encodings.Web => 0x2069600c4d9d1cfa => 136
	i64 2337758774805907496, ; 107: System.Runtime.CompilerServices.Unsafe => 0x207163383edbc828 => 101
	i64 2343783402604882194, ; 108: Xamarin.Grpc.Stub.dll => 0x2086ca9636b86912 => 371
	i64 2405413894731521496, ; 109: da/Microsoft.Maui.Controls.resources => 0x2161bf315d42ddd8 => 385
	i64 2445261912722553526, ; 110: Google.Cloud.Firestore.dll => 0x21ef50c10a9ebab6 => 182
	i64 2470498323731680442, ; 111: Xamarin.AndroidX.CoordinatorLayout => 0x2248f922dc398cba => 258
	i64 2479423007379663237, ; 112: Xamarin.AndroidX.VectorDrawable.Animated.dll => 0x2268ae16b2cba985 => 303
	i64 2492380397191429704, ; 113: cs/Microsoft.Maui.Controls.resources => 0x2296b6c41bbdfe48 => 384
	i64 2497223385847772520, ; 114: System.Runtime => 0x22a7eb7046413568 => 116
	i64 2547086958574651984, ; 115: Xamarin.AndroidX.Activity.dll => 0x2359121801df4a50 => 242
	i64 2592350477072141967, ; 116: System.Xml.dll => 0x23f9e10627330e8f => 163
	i64 2612152650457191105, ; 117: Microsoft.IdentityModel.Tokens.dll => 0x24403afeed9892c1 => 205
	i64 2624866290265602282, ; 118: mscorlib.dll => 0x246d65fbde2db8ea => 166
	i64 2632269733008246987, ; 119: System.Net.NameResolution => 0x2487b36034f808cb => 67
	i64 2656907746661064104, ; 120: Microsoft.Extensions.DependencyInjection => 0x24df3b84c8b75da8 => 195
	i64 2706075432581334785, ; 121: System.Net.WebSockets => 0x258de944be6c0701 => 80
	i64 2783046991838674048, ; 122: System.Runtime.CompilerServices.Unsafe.dll => 0x269f5e7e6dc37c80 => 101
	i64 2787234703088983483, ; 123: Xamarin.AndroidX.Startup.StartupRuntime => 0x26ae3f31ef429dbb => 298
	i64 2789714023057451704, ; 124: Microsoft.IdentityModel.JsonWebTokens.dll => 0x26b70e1f9943eab8 => 203
	i64 2812926542227278819, ; 125: Google.Apis.Core.dll => 0x270985c960b98be3 => 181
	i64 2815524396660695947, ; 126: System.Security.AccessControl => 0x2712c0857f68238b => 117
	i64 2851879596360956261, ; 127: System.Configuration.ConfigurationManager => 0x2793e9620b477965 => 230
	i64 2923871038697555247, ; 128: Jsr305Binding => 0x2893ad37e69ec52f => 341
	i64 2951672403965468947, ; 129: Xamarin.Firebase.Database.Collection => 0x28f67269abaf6113 => 320
	i64 2954987430423977617, ; 130: Xamarin.GooglePlayServices.Auth.Base => 0x290239696a2a5e91 => 352
	i64 3017136373564924869, ; 131: System.Net.WebProxy => 0x29df058bd93f63c5 => 78
	i64 3017704767998173186, ; 132: Xamarin.Google.Android.Material => 0x29e10a7f7d88a002 => 340
	i64 3081114052123444208, ; 133: EcommerceApp.dll => 0x2ac250e7ed4843f0 => 0
	i64 3106852385031680087, ; 134: System.Runtime.Serialization.Xml => 0x2b1dc1c88b637057 => 114
	i64 3107556380337382748, ; 135: pt/Microsoft.Maui.Controls.resources => 0x2b2042103982255c => 404
	i64 3110390492489056344, ; 136: System.Security.Cryptography.Csp.dll => 0x2b2a53ac61900058 => 121
	i64 3135773902340015556, ; 137: System.IO.FileSystem.DriveInfo.dll => 0x2b8481c008eac5c4 => 48
	i64 3143515969535650208, ; 138: Xamarin.Firebase.Encoders => 0x2ba0031e85f0a9a0 => 323
	i64 3171992396844006720, ; 139: Square.OkIO => 0x2c052e476c207d40 => 227
	i64 3202009568827554833, ; 140: th/Microsoft.Maui.Controls.resources => 0x2c6fd2bce55e3c11 => 409
	i64 3238539556702659506, ; 141: Microsoft.Win32.SystemEvents.dll => 0x2cf19a917c5023b2 => 213
	i64 3281594302220646930, ; 142: System.Security.Principal => 0x2d8a90a198ceba12 => 128
	i64 3289520064315143713, ; 143: Xamarin.AndroidX.Lifecycle.Common => 0x2da6b911e3063621 => 274
	i64 3303437397778967116, ; 144: Xamarin.AndroidX.Annotation.Experimental => 0x2dd82acf985b2a4c => 245
	i64 3311221304742556517, ; 145: System.Numerics.Vectors.dll => 0x2df3d23ba9e2b365 => 82
	i64 3325875462027654285, ; 146: System.Runtime.Numerics => 0x2e27e21c8958b48d => 110
	i64 3328853167529574890, ; 147: System.Net.Sockets.dll => 0x2e327651a008c1ea => 75
	i64 3344514922410554693, ; 148: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x2e6a1a9a18463545 => 380
	i64 3364695309916733813, ; 149: Xamarin.Firebase.Common => 0x2eb1cc8eb5028175 => 316
	i64 3402534845034375023, ; 150: System.IdentityModel.Tokens.Jwt.dll => 0x2f383b6a0629a76f => 232
	i64 3411255996856937470, ; 151: Xamarin.GooglePlayServices.Basement => 0x2f5737416a942bfe => 354
	i64 3427548605411023127, ; 152: Xamarin.GooglePlayServices.Auth.Api.Phone.dll => 0x2f91194bf3e8d917 => 351
	i64 3429672777697402584, ; 153: Microsoft.Maui.Essentials => 0x2f98a5385a7b1ed8 => 210
	i64 3430216265859992823, ; 154: Grpc.Auth.dll => 0x2f9a93850d5a0cf7 => 188
	i64 3437845325506641314, ; 155: System.IO.MemoryMappedFiles.dll => 0x2fb5ae1beb8f7da2 => 53
	i64 3493805808809882663, ; 156: Xamarin.AndroidX.Tracing.Tracing.dll => 0x307c7ddf444f3427 => 300
	i64 3494946837667399002, ; 157: Microsoft.Extensions.Configuration => 0x30808ba1c00a455a => 193
	i64 3495566828071521632, ; 158: Xamarin.GooglePlayServices.Measurement.Api.dll => 0x3082bf8283d78d60 => 357
	i64 3508450208084372758, ; 159: System.Net.Ping => 0x30b084e02d03ad16 => 69
	i64 3522470458906976663, ; 160: Xamarin.AndroidX.SwipeRefreshLayout => 0x30e2543832f52197 => 299
	i64 3531994851595924923, ; 161: System.Numerics => 0x31042a9aade235bb => 83
	i64 3551103847008531295, ; 162: System.Private.CoreLib.dll => 0x31480e226177735f => 172
	i64 3571415421602489686, ; 163: System.Runtime.dll => 0x319037675df7e556 => 116
	i64 3634544395678783861, ; 164: System.ServiceModel => 0x32707edf08d21975 => 212
	i64 3638003163729360188, ; 165: Microsoft.Extensions.Configuration.Abstractions => 0x327cc89a39d5f53c => 194
	i64 3647754201059316852, ; 166: System.Xml.ReaderWriter => 0x329f6d1e86145474 => 156
	i64 3655542548057982301, ; 167: Microsoft.Extensions.Configuration.dll => 0x32bb18945e52855d => 193
	i64 3659371656528649588, ; 168: Xamarin.Android.Glide.Annotations => 0x32c8b3222885dd74 => 239
	i64 3716579019761409177, ; 169: netstandard.dll => 0x3393f0ed5c8c5c99 => 167
	i64 3727469159507183293, ; 170: Xamarin.AndroidX.RecyclerView => 0x33baa1739ba646bd => 292
	i64 3772598417116884899, ; 171: Xamarin.AndroidX.DynamicAnimation.dll => 0x345af645b473efa3 => 266
	i64 3774315325518692048, ; 172: Xamarin.GooglePlayServices.Measurement.Sdk.Api.dll => 0x34610fca97dabed0 => 361
	i64 3859219695630330898, ; 173: Xamarin.GooglePlayServices.Ads.Identifier => 0x358eb3ddbc3cac12 => 349
	i64 3869221888984012293, ; 174: Microsoft.Extensions.Logging.dll => 0x35b23cceda0ed605 => 197
	i64 3869649043256705283, ; 175: System.Diagnostics.Tools => 0x35b3c14d74bf0103 => 32
	i64 3890352374528606784, ; 176: Microsoft.Maui.Controls.Xaml.dll => 0x35fd4edf66e00240 => 208
	i64 3893087497687830326, ; 177: Google.Cloud.Firestore.V1.dll => 0x36070673e3328f36 => 183
	i64 3919223565570527920, ; 178: System.Security.Cryptography.Encoding => 0x3663e111652bd2b0 => 122
	i64 3933965368022646939, ; 179: System.Net.Requests => 0x369840a8bfadc09b => 72
	i64 3966267475168208030, ; 180: System.Memory => 0x370b03412596249e => 62
	i64 4006972109285359177, ; 181: System.Xml.XmlDocument => 0x379b9fe74ed9fe49 => 161
	i64 4009997192427317104, ; 182: System.Runtime.Serialization.Primitives => 0x37a65f335cf1a770 => 113
	i64 4045730230152541805, ; 183: Xamarin.Grpc.Protobuf.Lite.dll => 0x38255235894d366d => 370
	i64 4056584864658557221, ; 184: Google.Apis.Auth => 0x384be27113330925 => 180
	i64 4073500526318903918, ; 185: System.Private.Xml.dll => 0x3887fb25779ae26e => 88
	i64 4073631083018132676, ; 186: Microsoft.Maui.Controls.Compatibility.dll => 0x388871e311491cc4 => 206
	i64 4085039559542030877, ; 187: Plugin.Firebase.RemoteConfig => 0x38b0f9d5ffebc21d => 224
	i64 4148881117810174540, ; 188: System.Runtime.InteropServices.JavaScript.dll => 0x3993c9651a66aa4c => 105
	i64 4154383907710350974, ; 189: System.ComponentModel => 0x39a7562737acb67e => 18
	i64 4156011472231154272, ; 190: Plugin.Firebase.Crashlytics => 0x39ad1e6a1cc94260 => 220
	i64 4167269041631776580, ; 191: System.Threading.ThreadPool => 0x39d51d1d3df1cf44 => 146
	i64 4168469861834746866, ; 192: System.Security.Claims.dll => 0x39d96140fb94ebf2 => 118
	i64 4187479170553454871, ; 193: System.Linq.Expressions => 0x3a1cea1e912fa117 => 58
	i64 4201423742386704971, ; 194: Xamarin.AndroidX.Core.Core.Ktx => 0x3a4e74a233da124b => 260
	i64 4205801962323029395, ; 195: System.ComponentModel.TypeConverter => 0x3a5e0299f7e7ad93 => 17
	i64 4235503420553921860, ; 196: System.IO.IsolatedStorage.dll => 0x3ac787eb9b118544 => 52
	i64 4239882675311405204, ; 197: Xamarin.Firebase.Encoders.JSON => 0x3ad716d44f44e894 => 324
	i64 4247996603072512073, ; 198: Xamarin.GooglePlayServices.Tasks => 0x3af3ea6755340049 => 364
	i64 4282138915307457788, ; 199: System.Reflection.Emit => 0x3b6d36a7ddc70cfc => 92
	i64 4335356748765836238, ; 200: Xamarin.Google.Android.DataTransport.TransportBackendCct => 0x3c2a47fe48c7b3ce => 338
	i64 4344734875814815696, ; 201: Plugin.Firebase.Analytics.dll => 0x3c4b9959a43167d0 => 216
	i64 4356591372459378815, ; 202: vi/Microsoft.Maui.Controls.resources.dll => 0x3c75b8c562f9087f => 412
	i64 4373617458794931033, ; 203: System.IO.Pipes.dll => 0x3cb235e806eb2359 => 55
	i64 4397634830160618470, ; 204: System.Security.SecureString.dll => 0x3d0789940f9be3e6 => 129
	i64 4432316908210594816, ; 205: Xamarin.GooglePlayServices.Measurement.Impl => 0x3d82c0be9dd9a400 => 359
	i64 4477672992252076438, ; 206: System.Web.HttpUtility.dll => 0x3e23e3dcdb8ba196 => 152
	i64 4484706122338676047, ; 207: System.Globalization.Extensions.dll => 0x3e3ce07510042d4f => 41
	i64 4500292229471022193, ; 208: Xamarin.Google.Dagger.dll => 0x3e743ff06b122c71 => 343
	i64 4533124835995628778, ; 209: System.Reflection.Emit.dll => 0x3ee8e505540534ea => 92
	i64 4636684751163556186, ; 210: Xamarin.AndroidX.VersionedParcelable.dll => 0x4058d0370893015a => 304
	i64 4672453897036726049, ; 211: System.IO.FileSystem.Watcher => 0x40d7e4104a437f21 => 50
	i64 4679594760078841447, ; 212: ar/Microsoft.Maui.Controls.resources.dll => 0x40f142a407475667 => 382
	i64 4702770163853758138, ; 213: Xamarin.Firebase.Components => 0x4143988c34cf0eba => 317
	i64 4708653840312162517, ; 214: Square.OkHttp3 => 0x41587fb86215d8d5 => 226
	i64 4716677666592453464, ; 215: System.Xml.XmlSerializer => 0x417501590542f358 => 162
	i64 4743821336939966868, ; 216: System.ComponentModel.Annotations => 0x41d5705f4239b194 => 13
	i64 4759461199762736555, ; 217: Xamarin.AndroidX.Lifecycle.Process.dll => 0x420d00be961cc5ab => 278
	i64 4794310189461587505, ; 218: Xamarin.AndroidX.Activity => 0x4288cfb749e4c631 => 242
	i64 4795410492532947900, ; 219: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0x428cb86f8f9b7bbc => 299
	i64 4809057822547766521, ; 220: System.Drawing => 0x42bd349c3145ecf9 => 36
	i64 4814660307502931973, ; 221: System.Net.NameResolution.dll => 0x42d11c0a5ee2a005 => 67
	i64 4822137366104089610, ; 222: Xamarin.GooglePlayServices.Measurement.Sdk.Api => 0x42ebac62bcc5a40a => 361
	i64 4835744211636393215, ; 223: fi/Microsoft.Maui.Controls.resources => 0x431c03bd573d14ff => 389
	i64 4853321196694829351, ; 224: System.Runtime.Loader.dll => 0x435a75ea15de7927 => 109
	i64 4853355175641069576, ; 225: Plugin.Firebase.RemoteConfig.dll => 0x435a94d16ce3b808 => 224
	i64 5005291387232977212, ; 226: Xamarin.GooglePlayServices.Measurement.dll => 0x45765dff5d58013c => 356
	i64 5055365687667823624, ; 227: Xamarin.AndroidX.Activity.Ktx.dll => 0x4628444ef7239408 => 243
	i64 5081566143765835342, ; 228: System.Resources.ResourceManager.dll => 0x4685597c05d06e4e => 99
	i64 5098983611934048327, ; 229: Google.Cloud.Location => 0x46c33a9458de0047 => 184
	i64 5099468265966638712, ; 230: System.Resources.ResourceManager => 0x46c4f35ea8519678 => 99
	i64 5103417709280584325, ; 231: System.Collections.Specialized => 0x46d2fb5e161b6285 => 11
	i64 5182934613077526976, ; 232: System.Collections.Specialized.dll => 0x47ed7b91fa9009c0 => 11
	i64 5205316157927637098, ; 233: Xamarin.AndroidX.LocalBroadcastManager => 0x483cff7778e0c06a => 285
	i64 5244375036463807528, ; 234: System.Diagnostics.Contracts.dll => 0x48c7c34f4d59fc28 => 25
	i64 5258427006098912452, ; 235: Xamarin.GooglePlayServices.Auth.Base.dll => 0x48f9af806fd8b4c4 => 352
	i64 5262971552273843408, ; 236: System.Security.Principal.dll => 0x4909d4be0c44c4d0 => 128
	i64 5278787618751394462, ; 237: System.Net.WebClient.dll => 0x4942055efc68329e => 76
	i64 5280980186044710147, ; 238: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 0x4949cf7fd7123d03 => 277
	i64 5290215063822704973, ; 239: Xamarin.Grpc.Stub => 0x496a9e926092a14d => 371
	i64 5290786973231294105, ; 240: System.Runtime.Loader => 0x496ca6b869b72699 => 109
	i64 5376510917114486089, ; 241: Xamarin.AndroidX.VectorDrawable.Animated => 0x4a9d3431719e5d49 => 303
	i64 5408338804355907810, ; 242: Xamarin.AndroidX.Transition => 0x4b0e477cea9840e2 => 301
	i64 5423376490970181369, ; 243: System.Runtime.InteropServices.RuntimeInformation => 0x4b43b42f2b7b6ef9 => 106
	i64 5424404247311656595, ; 244: Xamarin.GooglePlayServices.SafetyNet.dll => 0x4b475aec5721a693 => 362
	i64 5426193594926737925, ; 245: Plugin.Firebase.Core => 0x4b4db6534c1baa05 => 219
	i64 5440320908473006344, ; 246: Microsoft.VisualBasic.Core => 0x4b7fe70acda9f908 => 2
	i64 5446034149219586269, ; 247: System.Diagnostics.Debug => 0x4b94333452e150dd => 26
	i64 5451019430259338467, ; 248: Xamarin.AndroidX.ConstraintLayout.dll => 0x4ba5e94a845c2ce3 => 256
	i64 5457765010617926378, ; 249: System.Xml.Serialization => 0x4bbde05c557002ea => 157
	i64 5488847537322884930, ; 250: System.Windows.Extensions => 0x4c2c4dc108687f42 => 237
	i64 5507995362134886206, ; 251: System.Core.dll => 0x4c705499688c873e => 21
	i64 5527431512186326818, ; 252: System.IO.FileSystem.Primitives.dll => 0x4cb561acbc2a8f22 => 49
	i64 5570799893513421663, ; 253: System.IO.Compression.Brotli => 0x4d4f74fcdfa6c35f => 43
	i64 5573260873512690141, ; 254: System.Security.Cryptography.dll => 0x4d58333c6e4ea1dd => 126
	i64 5574231584441077149, ; 255: Xamarin.AndroidX.Annotation.Jvm => 0x4d5ba617ae5f8d9d => 246
	i64 5591791169662171124, ; 256: System.Linq.Parallel => 0x4d9a087135e137f4 => 59
	i64 5628362754859641198, ; 257: Xamarin.Firebase.Storage.Common.dll => 0x4e1bf61aee72a96e => 336
	i64 5650097808083101034, ; 258: System.Security.Cryptography.Algorithms.dll => 0x4e692e055d01a56a => 119
	i64 5665389054145784248, ; 259: Google.Apis.Core => 0x4e9f815406bee9b8 => 181
	i64 5692067934154308417, ; 260: Xamarin.AndroidX.ViewPager2.dll => 0x4efe49a0d4a8bb41 => 306
	i64 5724799082821825042, ; 261: Xamarin.AndroidX.ExifInterface => 0x4f72926f3e13b212 => 269
	i64 5757522595884336624, ; 262: Xamarin.AndroidX.Concurrent.Futures.dll => 0x4fe6d44bd9f885f0 => 255
	i64 5783556987928984683, ; 263: Microsoft.VisualBasic => 0x504352701bbc3c6b => 3
	i64 5896680224035167651, ; 264: Xamarin.AndroidX.Lifecycle.LiveData.dll => 0x51d5376bfbafdda3 => 275
	i64 5909949808044991351, ; 265: Xamarin.GooglePlayServices.Measurement => 0x52045c09c4e8e377 => 356
	i64 5939174725034091446, ; 266: pt-BR/Microsoft.Maui.Controls.resources => 0x526c2ff200a2a3b6 => 403
	i64 5959344983920014087, ; 267: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 0x52b3d8b05c8ef307 => 295
	i64 5979151488806146654, ; 268: System.Formats.Asn1 => 0x52fa3699a489d25e => 38
	i64 5984759512290286505, ; 269: System.Security.Cryptography.Primitives => 0x530e23115c33dba9 => 124
	i64 6068057819846744445, ; 270: ro/Microsoft.Maui.Controls.resources.dll => 0x5436126fec7f197d => 405
	i64 6076057840849113382, ; 271: Xamarin.Firebase.Dynamic.Links.dll => 0x54527e69f689d126 => 322
	i64 6092862891035488599, ; 272: Xamarin.Firebase.Measurement.Connector.dll => 0x548e32849d547157 => 332
	i64 6102788177522843259, ; 273: Xamarin.AndroidX.SavedState.SavedState.Ktx => 0x54b1758374b3de7b => 295
	i64 6118452257458269359, ; 274: Xamarin.Firebase.AppCheck.Interop.dll => 0x54e91be944fcacaf => 313
	i64 6135981624229292808, ; 275: Xamarin.Grpc.Api.dll => 0x552762c70482eb08 => 366
	i64 6218967553231149354, ; 276: Firebase.Auth.dll => 0x564e360a4805d92a => 173
	i64 6222399776351216807, ; 277: System.Text.Json.dll => 0x565a67a0ffe264a7 => 137
	i64 6251069312384999852, ; 278: System.Transactions.Local => 0x56c0426b870da1ac => 149
	i64 6278736998281604212, ; 279: System.Private.DataContractSerialization => 0x57228e08a4ad6c74 => 85
	i64 6284145129771520194, ; 280: System.Reflection.Emit.ILGeneration => 0x5735c4b3610850c2 => 90
	i64 6300241346327543539, ; 281: Xamarin.Firebase.Iid => 0x576ef41fd714fef3 => 328
	i64 6319713645133255417, ; 282: Xamarin.AndroidX.Lifecycle.Runtime => 0x57b42213b45b52f9 => 279
	i64 6357457916754632952, ; 283: _Microsoft.Android.Resource.Designer => 0x583a3a4ac2a7a0f8 => 416
	i64 6401242110442382339, ; 284: Xamarin.Protobuf.JavaLite => 0x58d5c7c8c230a403 => 381
	i64 6401687960814735282, ; 285: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0x58d75d486341cfb2 => 276
	i64 6403742896930319886, ; 286: Xamarin.Firebase.Auth.dll => 0x58deaa3c7c766e0e => 314
	i64 6444987688569083917, ; 287: Plugin.Firebase.Storage.dll => 0x59713227deed180d => 225
	i64 6504860066809920875, ; 288: Xamarin.AndroidX.Browser.dll => 0x5a45e7c43bd43d6b => 251
	i64 6522864429860654155, ; 289: Plugin.Firebase => 0x5a85dea3abe00c4b => 215
	i64 6548213210057960872, ; 290: Xamarin.AndroidX.CustomView.dll => 0x5adfed387b066da8 => 262
	i64 6554405243736097249, ; 291: Xamarin.GooglePlayServices.Stats => 0x5af5ecd7aad901e1 => 363
	i64 6557084851308642443, ; 292: Xamarin.AndroidX.Window.dll => 0x5aff71ee6c58c08b => 307
	i64 6560151584539558821, ; 293: Microsoft.Extensions.Options => 0x5b0a571be53243a5 => 200
	i64 6589202984700901502, ; 294: Xamarin.Google.ErrorProne.Annotations.dll => 0x5b718d34180a787e => 344
	i64 6591971792923354531, ; 295: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 0x5b7b636b7e9765a3 => 277
	i64 6594803674001204912, ; 296: Plugin.Firebase.CloudMessaging => 0x5b857300304866b0 => 218
	i64 6617685658146568858, ; 297: System.Text.Encoding.CodePages => 0x5bd6be0b4905fa9a => 133
	i64 6690776524695692178, ; 298: Xamarin.Firebase.Crashlytics.dll => 0x5cda69ccca026392 => 319
	i64 6713440830605852118, ; 299: System.Reflection.TypeExtensions.dll => 0x5d2aeeddb8dd7dd6 => 96
	i64 6734140735192831707, ; 300: uk/Microsoft.Maui.Controls.resources => 0x5d747951d4a816db => 411
	i64 6737082967062634076, ; 301: Xamarin.GooglePlayServices.Ads.Identifier.dll => 0x5d7eed43921a5e5c => 349
	i64 6739853162153639747, ; 302: Microsoft.VisualBasic.dll => 0x5d88c4bde075ff43 => 3
	i64 6772837112740759457, ; 303: System.Runtime.InteropServices.JavaScript => 0x5dfdf378527ec7a1 => 105
	i64 6777482997383978746, ; 304: pt/Microsoft.Maui.Controls.resources.dll => 0x5e0e74e0a2525efa => 404
	i64 6786606130239981554, ; 305: System.Diagnostics.TraceSource => 0x5e2ede51877147f2 => 33
	i64 6798329586179154312, ; 306: System.Windows => 0x5e5884bd523ca188 => 154
	i64 6814185388980153342, ; 307: System.Xml.XDocument.dll => 0x5e90d98217d1abfe => 158
	i64 6876862101832370452, ; 308: System.Xml.Linq => 0x5f6f85a57d108914 => 155
	i64 6878582369430612696, ; 309: Xamarin.Google.Android.DataTransport.TransportRuntime.dll => 0x5f75a238802d2ad8 => 339
	i64 6894844156784520562, ; 310: System.Numerics.Vectors => 0x5faf683aead1ad72 => 82
	i64 6934772601320367100, ; 311: Google.Api.Gax.Rest => 0x603d42f05bcfe3fc => 178
	i64 6975328107116786489, ; 312: Xamarin.Firebase.Annotations => 0x60cd57f4e07e7339 => 312
	i64 6987056692196838363, ; 313: System.Management => 0x60f7030ae3e88bdb => 234
	i64 7007997260651418532, ; 314: Xamarin.Firebase.Analytics.dll => 0x61416860ec09d3a4 => 311
	i64 7011053663211085209, ; 315: Xamarin.AndroidX.Fragment.Ktx => 0x614c442918e5dd99 => 271
	i64 7026573318513401069, ; 316: Xamarin.Firebase.Encoders.Proto.dll => 0x618367346e3a9ced => 325
	i64 7060896174307865760, ; 317: System.Threading.Tasks.Parallel.dll => 0x61fd57a90988f4a0 => 143
	i64 7083415169664825468, ; 318: EcommerceApp => 0x624d5891387c387c => 0
	i64 7083547580668757502, ; 319: System.Private.Xml.Linq.dll => 0x624dd0fe8f56c5fe => 87
	i64 7101497697220435230, ; 320: System.Configuration => 0x628d9687c0141d1e => 19
	i64 7103753931438454322, ; 321: Xamarin.AndroidX.Interpolator.dll => 0x62959a90372c7632 => 272
	i64 7112547816752919026, ; 322: System.IO.FileSystem => 0x62b4d88e3189b1f2 => 51
	i64 7158676156446871556, ; 323: Xamarin.Firebase.Functions.dll => 0x6358ba0937131004 => 327
	i64 7192745174564810625, ; 324: Xamarin.Android.Glide.GifDecoder.dll => 0x63d1c3a0a1d72f81 => 241
	i64 7220009545223068405, ; 325: sv/Microsoft.Maui.Controls.resources.dll => 0x6432a06d99f35af5 => 408
	i64 7270811800166795866, ; 326: System.Linq => 0x64e71ccf51a90a5a => 61
	i64 7299370801165188114, ; 327: System.IO.Pipes.AccessControl.dll => 0x654c9311e74f3c12 => 54
	i64 7316205155833392065, ; 328: Microsoft.Win32.Primitives => 0x658861d38954abc1 => 4
	i64 7338192458477945005, ; 329: System.Reflection => 0x65d67f295d0740ad => 97
	i64 7349431895026339542, ; 330: Xamarin.Android.Glide.DiskLruCache => 0x65fe6d5e9bf88ed6 => 240
	i64 7377312882064240630, ; 331: System.ComponentModel.TypeConverter.dll => 0x66617afac45a2ff6 => 17
	i64 7385250113861300937, ; 332: Xamarin.Firebase.Iid.Interop.dll => 0x667dadd98e1db2c9 => 329
	i64 7439799228237803094, ; 333: it/Microsoft.Maui.Controls.resources => 0x673f79faf756ee56 => 396
	i64 7446349959216394011, ; 334: Plugin.Firebase.DynamicLinks.dll => 0x6756bfd5e0566f1b => 221
	i64 7476537270401454554, ; 335: Xamarin.Firebase.Encoders.JSON.dll => 0x67c1ff08f83f51da => 324
	i64 7488575175965059935, ; 336: System.Xml.Linq.dll => 0x67ecc3724534ab5f => 155
	i64 7489048572193775167, ; 337: System.ObjectModel => 0x67ee71ff6b419e3f => 84
	i64 7496222613193209122, ; 338: System.IdentityModel.Tokens.Jwt => 0x6807eec000a1b522 => 232
	i64 7503526963013706253, ; 339: System.ServiceModel.dll => 0x6821e20478ff620d => 212
	i64 7515866667942440541, ; 340: Xamarin.Firebase.Storage.Common => 0x684db8e9e9e86e5d => 336
	i64 7586519340370716875, ; 341: Plugin.Firebase.Auth => 0x6948bb251c6d68cb => 217
	i64 7592577537120840276, ; 342: System.Diagnostics.Process => 0x695e410af5b2aa54 => 29
	i64 7621211152690795761, ; 343: Google.LongRunning.dll => 0x69c3fb2a1a6154f1 => 185
	i64 7637303409920963731, ; 344: System.IO.Compression.ZipFile.dll => 0x69fd26fcb637f493 => 45
	i64 7642002156153824904, ; 345: ro/Microsoft.Maui.Controls.resources => 0x6a0dd878d2516688 => 405
	i64 7654504624184590948, ; 346: System.Net.Http => 0x6a3a4366801b8264 => 64
	i64 7694700312542370399, ; 347: System.Net.Mail => 0x6ac9112a7e2cda5f => 66
	i64 7708790323521193081, ; 348: ms/Microsoft.Maui.Controls.resources.dll => 0x6afb1ff4d1730479 => 399
	i64 7711238313006071682, ; 349: Xamarin.GooglePlayServices.Measurement.Impl.dll => 0x6b03d263c91bff82 => 359
	i64 7714652370974252055, ; 350: System.Private.CoreLib => 0x6b0ff375198b9c17 => 172
	i64 7725404731275645577, ; 351: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 0x6b3626ac11ce9289 => 280
	i64 7735176074855944702, ; 352: Microsoft.CSharp => 0x6b58dda848e391fe => 1
	i64 7735352534559001595, ; 353: Xamarin.Kotlin.StdLib.dll => 0x6b597e2582ce8bfb => 375
	i64 7740912860115050295, ; 354: Google.Api.CommonProtos => 0x6b6d3f3bb0691f37 => 175
	i64 7791074099216502080, ; 355: System.IO.FileSystem.AccessControl.dll => 0x6c1f749d468bcd40 => 47
	i64 7820441508502274321, ; 356: System.Data => 0x6c87ca1e14ff8111 => 24
	i64 7836164640616011524, ; 357: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x6cbfa6390d64d704 => 248
	i64 7843473411302439824, ; 358: Google.LongRunning => 0x6cd99d82d5e73b90 => 185
	i64 7904570928025870493, ; 359: Xamarin.Firebase.Installations => 0x6db2ad60fadca09d => 330
	i64 7940488133782528123, ; 360: Xamarin.GooglePlayServices.CloudMessaging => 0x6e3247e31d4fe07b => 355
	i64 7969431548154767168, ; 361: Xamarin.Firebase.Installations.dll => 0x6e991bc4e98e6740 => 330
	i64 7974216756248484795, ; 362: Plugin.Firebase.Functions.dll => 0x6eaa1be3fe289bbb => 223
	i64 7991572870742010042, ; 363: Xamarin.Firebase.Firestore.dll => 0x6ee7c52f4d39e8ba => 326
	i64 8003335089973143038, ; 364: Square.OkHttp3.dll => 0x6f118edc6044a5fe => 226
	i64 8025517457475554965, ; 365: WindowsBase => 0x6f605d9b4786ce95 => 165
	i64 8031450141206250471, ; 366: System.Runtime.Intrinsics.dll => 0x6f757159d9dc03e7 => 108
	i64 8064050204834738623, ; 367: System.Collections.dll => 0x6fe942efa61731bf => 12
	i64 8083354569033831015, ; 368: Xamarin.AndroidX.Lifecycle.Common.dll => 0x702dd82730cad267 => 274
	i64 8085230611270010360, ; 369: System.Net.Http.Json.dll => 0x703482674fdd05f8 => 63
	i64 8087206902342787202, ; 370: System.Diagnostics.DiagnosticSource => 0x703b87d46f3aa082 => 27
	i64 8103644804370223335, ; 371: System.Data.DataSetExtensions.dll => 0x7075ee03be6d50e7 => 23
	i64 8113615946733131500, ; 372: System.Reflection.Extensions => 0x70995ab73cf916ec => 93
	i64 8167236081217502503, ; 373: Java.Interop.dll => 0x7157d9f1a9b8fd27 => 168
	i64 8185542183669246576, ; 374: System.Collections => 0x7198e33f4794aa70 => 12
	i64 8187640529827139739, ; 375: Xamarin.KotlinX.Coroutines.Android => 0x71a057ae90f0109b => 379
	i64 8246048515196606205, ; 376: Microsoft.Maui.Graphics.dll => 0x726fd96f64ee56fd => 211
	i64 8264926008854159966, ; 377: System.Diagnostics.Process.dll => 0x72b2ea6a64a3a25e => 29
	i64 8290740647658429042, ; 378: System.Runtime.Extensions => 0x730ea0b15c929a72 => 103
	i64 8293702073711834350, ; 379: System.Linq.Async => 0x731926181883b4ee => 233
	i64 8318905602908530212, ; 380: System.ComponentModel.DataAnnotations => 0x7372b092055ea624 => 14
	i64 8368701292315763008, ; 381: System.Security.Cryptography => 0x7423997c6fd56140 => 126
	i64 8398329775253868912, ; 382: Xamarin.AndroidX.ConstraintLayout.Core.dll => 0x748cdc6f3097d170 => 257
	i64 8400357532724379117, ; 383: Xamarin.AndroidX.Navigation.UI.dll => 0x749410ab44503ded => 289
	i64 8410671156615598628, ; 384: System.Reflection.Emit.Lightweight.dll => 0x74b8b4daf4b25224 => 91
	i64 8426919725312979251, ; 385: Xamarin.AndroidX.Lifecycle.Process => 0x74f26ed7aa033133 => 278
	i64 8428678171113854126, ; 386: Xamarin.Firebase.Iid.dll => 0x74f8ae23bb5494ae => 328
	i64 8465511506719290632, ; 387: Xamarin.Firebase.Messaging.dll => 0x757b89dcf7fc3508 => 333
	i64 8476857680833348370, ; 388: System.Security.Permissions.dll => 0x75a3d925fd9d0312 => 236
	i64 8515752553183989521, ; 389: el/Microsoft.Maui.Controls.resources => 0x762e07d427a84f11 => 387
	i64 8518412311883997971, ; 390: System.Collections.Immutable => 0x76377add7c28e313 => 9
	i64 8557640666902467377, ; 391: tr/Microsoft.Maui.Controls.resources => 0x76c2d8d8a2289331 => 410
	i64 8563666267364444763, ; 392: System.Private.Uri => 0x76d841191140ca5b => 86
	i64 8573305974629105867, ; 393: sk/Microsoft.Maui.Controls.resources => 0x76fa805c508080cb => 407
	i64 8598790081731763592, ; 394: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 0x77550a055fc61d88 => 268
	i64 8601935802264776013, ; 395: Xamarin.AndroidX.Transition.dll => 0x7760370982b4ed4d => 301
	i64 8609060182490045521, ; 396: Square.OkIO.dll => 0x7779869f8b475c51 => 227
	i64 8613760304861496997, ; 397: Xamarin.CodeHaus.Mojo.AnimalSnifferAnnotations.dll => 0x778a395c0fa146a5 => 309
	i64 8614108721271900878, ; 398: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x778b763e14018ace => 403
	i64 8623059219396073920, ; 399: System.Net.Quic.dll => 0x77ab42ac514299c0 => 71
	i64 8626175481042262068, ; 400: Java.Interop => 0x77b654e585b55834 => 168
	i64 8638972117149407195, ; 401: Microsoft.CSharp.dll => 0x77e3cb5e8b31d7db => 1
	i64 8639588376636138208, ; 402: Xamarin.AndroidX.Navigation.Runtime => 0x77e5fbdaa2fda2e0 => 288
	i64 8648495978913578441, ; 403: Microsoft.Win32.Registry.dll => 0x7805a1456889bdc9 => 5
	i64 8684531736582871431, ; 404: System.IO.Compression.FileSystem => 0x7885a79a0fa0d987 => 44
	i64 8685687024490312494, ; 405: Google.Api.Gax.Grpc => 0x7889c2547cf6f32e => 177
	i64 8725526185868997716, ; 406: System.Diagnostics.DiagnosticSource.dll => 0x79174bd613173454 => 27
	i64 8828892993892926228, ; 407: Xamarin.Firebase.Config.dll => 0x7a86876684ec4314 => 318
	i64 8834404175818295388, ; 408: Xamarin.Firebase.Dynamic.Links => 0x7a9a1bca8de0885c => 322
	i64 8853378295825400934, ; 409: Xamarin.Kotlin.StdLib.Common.dll => 0x7add84a720d38466 => 376
	i64 8906941675023136603, ; 410: he/Microsoft.Maui.Controls.resources => 0x7b9bd0432ee0775b => 391
	i64 8941376889969657626, ; 411: System.Xml.XDocument => 0x7c1626e87187471a => 158
	i64 8951477988056063522, ; 412: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 0x7c3a09cd9ccf5e22 => 291
	i64 8954753533646919997, ; 413: System.Runtime.Serialization.Json => 0x7c45ace50032d93d => 112
	i64 9017840326336271361, ; 414: Xamarin.Firebase.Functions => 0x7d25cdff8c775401 => 327
	i64 9043227163227252164, ; 415: Xamarin.GooglePlayServices.SafetyNet => 0x7d7fff311f52e5c4 => 362
	i64 9087864182143226060, ; 416: Xamarin.GooglePlayServices.Measurement.Sdk.dll => 0x7e1e9452f7a490cc => 360
	i64 9113579748781016974, ; 417: Xamarin.Firebase.Storage.dll => 0x7e79f07ee649478e => 335
	i64 9138683372487561558, ; 418: System.Security.Cryptography.Csp => 0x7ed3201bc3e3d156 => 121
	i64 9285318971778582014, ; 419: Plugin.Firebase.Core.dll => 0x80dc1468bb0ec5fe => 219
	i64 9312692141327339315, ; 420: Xamarin.AndroidX.ViewPager2 => 0x813d54296a634f33 => 306
	i64 9324707631942237306, ; 421: Xamarin.AndroidX.AppCompat => 0x8168042fd44a7c7a => 247
	i64 9358526837836468481, ; 422: Xamarin.GooglePlayServices.Measurement.Base.dll => 0x81e02a934e33d101 => 358
	i64 9404599086328396064, ; 423: Grpc.Net.Client.dll => 0x8283d90a93913920 => 190
	i64 9427266486299436557, ; 424: Microsoft.IdentityModel.Logging.dll => 0x82d460ebe6d2a60d => 204
	i64 9468215723722196442, ; 425: System.Xml.XPath.XDocument.dll => 0x8365dc09353ac5da => 159
	i64 9554839972845591462, ; 426: System.ServiceModel.Web => 0x84999c54e32a1ba6 => 131
	i64 9575902398040817096, ; 427: Xamarin.Google.Crypto.Tink.Android.dll => 0x84e4707ee708bdc8 => 342
	i64 9584643793929893533, ; 428: System.IO.dll => 0x85037ebfbbd7f69d => 57
	i64 9659729154652888475, ; 429: System.Text.RegularExpressions => 0x860e407c9991dd9b => 138
	i64 9662334977499516867, ; 430: System.Numerics.dll => 0x8617827802b0cfc3 => 83
	i64 9667360217193089419, ; 431: System.Diagnostics.StackTrace => 0x86295ce5cd89898b => 30
	i64 9678050649315576968, ; 432: Xamarin.AndroidX.CoordinatorLayout.dll => 0x864f57c9feb18c88 => 258
	i64 9702891218465930390, ; 433: System.Collections.NonGeneric.dll => 0x86a79827b2eb3c96 => 10
	i64 9735414641753518179, ; 434: Xamarin.Firebase.Encoders.Proto => 0x871b240946daf063 => 325
	i64 9774216967140627647, ; 435: Xamarin.Firebase.Datatransport.dll => 0x87a4fe8bac0354bf => 321
	i64 9780093022148426479, ; 436: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 0x87b9dec9576efaef => 308
	i64 9796610708422913120, ; 437: Xamarin.Firebase.Iid.Interop => 0x87f48d88de55ec60 => 329
	i64 9808709177481450983, ; 438: Mono.Android.dll => 0x881f890734e555e7 => 171
	i64 9825649861376906464, ; 439: Xamarin.AndroidX.Concurrent.Futures => 0x885bb87d8abc94e0 => 255
	i64 9834056768316610435, ; 440: System.Transactions.dll => 0x8879968718899783 => 150
	i64 9836529246295212050, ; 441: System.Reflection.Metadata => 0x88825f3bbc2ac012 => 94
	i64 9875200773399460291, ; 442: Xamarin.GooglePlayServices.Base.dll => 0x890bc2c8482339c3 => 353
	i64 9884103019517044980, ; 443: hi/Microsoft.Maui.Controls.resources => 0x892b6353f9ade8f4 => 392
	i64 9907349773706910547, ; 444: Xamarin.AndroidX.Emoji2.ViewsHelper => 0x897dfa20b758db53 => 268
	i64 9933555792566666578, ; 445: System.Linq.Queryable.dll => 0x89db145cf475c552 => 60
	i64 9956195530459977388, ; 446: Microsoft.Maui => 0x8a2b8315b36616ac => 209
	i64 9959489431142554298, ; 447: System.CodeDom => 0x8a3736deb7825aba => 229
	i64 9974604633896246661, ; 448: System.Xml.Serialization.dll => 0x8a6cea111a59dd85 => 157
	i64 9991543690424095600, ; 449: es/Microsoft.Maui.Controls.resources.dll => 0x8aa9180c89861370 => 388
	i64 10017511394021241210, ; 450: Microsoft.Extensions.Logging.Debug => 0x8b055989ae10717a => 199
	i64 10038780035334861115, ; 451: System.Net.Http.dll => 0x8b50e941206af13b => 64
	i64 10051358222726253779, ; 452: System.Private.Xml => 0x8b7d990c97ccccd3 => 88
	i64 10051920404523413229, ; 453: Grpc.Net.Common => 0x8b7f9859be1e6eed => 191
	i64 10071983904436292605, ; 454: Xamarin.CodeHaus.Mojo.AnimalSnifferAnnotations => 0x8bc6dfff57608bfd => 309
	i64 10078727084704864206, ; 455: System.Net.WebSockets.Client => 0x8bded4e257f117ce => 79
	i64 10089571585547156312, ; 456: System.IO.FileSystem.AccessControl => 0x8c055be67469bb58 => 47
	i64 10092835686693276772, ; 457: Microsoft.Maui.Controls => 0x8c10f49539bd0c64 => 207
	i64 10104292372708262378, ; 458: Xamarin.GooglePlayServices.Measurement.Base => 0x8c39a860cdf701ea => 358
	i64 10105485790837105934, ; 459: System.Threading.Tasks.Parallel => 0x8c3de5c91d9a650e => 143
	i64 10167561595017141208, ; 460: Xamarin.GoogleAndroid.Annotations.dll => 0x8d1a6f668ee69bd8 => 348
	i64 10220684565739810458, ; 461: FirebaseAdmin => 0x8dd72a76063d2e9a => 174
	i64 10226222362177979215, ; 462: Xamarin.Kotlin.StdLib.Jdk7 => 0x8dead70ebbc6434f => 377
	i64 10226489408795347955, ; 463: sv/Microsoft.Maui.Controls.resources => 0x8debc9ef5e8a8bf3 => 408
	i64 10229024438826829339, ; 464: Xamarin.AndroidX.CustomView => 0x8df4cb880b10061b => 262
	i64 10236703004850800690, ; 465: System.Net.ServicePoint.dll => 0x8e101325834e4832 => 74
	i64 10245369515835430794, ; 466: System.Reflection.Emit.Lightweight => 0x8e2edd4ad7fc978a => 91
	i64 10282208442277544177, ; 467: Google.Cloud.Firestore.V1 => 0x8eb1be19cc79c0f1 => 183
	i64 10321854143672141184, ; 468: Xamarin.Jetbrains.Annotations.dll => 0x8f3e97a7f8f8c580 => 374
	i64 10352330178246763130, ; 469: Xamarin.Firebase.Measurement.Connector => 0x8faadd72b7f4627a => 332
	i64 10360651442923773544, ; 470: System.Text.Encoding => 0x8fc86d98211c1e68 => 135
	i64 10364469296367737616, ; 471: System.Reflection.Emit.ILGeneration.dll => 0x8fd5fde967711b10 => 90
	i64 10376576884623852283, ; 472: Xamarin.AndroidX.Tracing.Tracing => 0x900101b2f888c2fb => 300
	i64 10406448008575299332, ; 473: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x906b2153fcb3af04 => 380
	i64 10430153318873392755, ; 474: Xamarin.AndroidX.Core => 0x90bf592ea44f6673 => 259
	i64 10447083246144586668, ; 475: Microsoft.Bcl.AsyncInterfaces.dll => 0x90fb7edc816203ac => 192
	i64 10546663366131771576, ; 476: System.Runtime.Serialization.Json.dll => 0x925d4673efe8e8b8 => 112
	i64 10566960649245365243, ; 477: System.Globalization.dll => 0x92a562b96dcd13fb => 42
	i64 10595762989148858956, ; 478: System.Xml.XPath.XDocument => 0x930bb64cc472ea4c => 159
	i64 10670374202010151210, ; 479: Microsoft.Win32.Primitives.dll => 0x9414c8cd7b4ea92a => 4
	i64 10714184849103829812, ; 480: System.Runtime.Extensions.dll => 0x94b06e5aa4b4bb34 => 103
	i64 10785150219063592792, ; 481: System.Net.Primitives => 0x95ac8cfb68830758 => 70
	i64 10822644899632537592, ; 482: System.Linq.Queryable => 0x9631c23204ca5ff8 => 60
	i64 10823124638835005028, ; 483: Google.Api.Gax.dll => 0x963376840189d664 => 176
	i64 10830817578243619689, ; 484: System.Formats.Tar => 0x964ecb340a447b69 => 39
	i64 10842631359359123634, ; 485: Plugin.Firebase.Auth.dll => 0x9678c3c64d1c80b2 => 217
	i64 10847732767863316357, ; 486: Xamarin.AndroidX.Arch.Core.Common => 0x968ae37a86db9f85 => 249
	i64 10854473764158213966, ; 487: Grpc.Core.Api.dll => 0x96a2d66108728f4e => 189
	i64 10857315922431607327, ; 488: Xamarin.Firebase.ProtoliteWellKnownTypes => 0x96acef4e92ba821f => 334
	i64 10899834349646441345, ; 489: System.Web => 0x9743fd975946eb81 => 153
	i64 10943875058216066601, ; 490: System.IO.UnmanagedMemoryStream.dll => 0x97e07461df39de29 => 56
	i64 10953751836886437922, ; 491: System.Linq.Async.dll => 0x98038b429b661022 => 233
	i64 10964653383833615866, ; 492: System.Diagnostics.Tracing => 0x982a4628ccaffdfa => 34
	i64 10966933586012635777, ; 493: Xamarin.Grpc.OkHttp.dll => 0x98325ffdbd958281 => 369
	i64 10984274332520666918, ; 494: zh-Hant/Microsoft.Maui.Controls.resources => 0x986ffb4ee955d726 => 415
	i64 11002576679268595294, ; 495: Microsoft.Extensions.Logging.Abstractions => 0x98b1013215cd365e => 198
	i64 11009005086950030778, ; 496: Microsoft.Maui.dll => 0x98c7d7cc621ffdba => 209
	i64 11019817191295005410, ; 497: Xamarin.AndroidX.Annotation.Jvm.dll => 0x98ee415998e1b2e2 => 246
	i64 11023048688141570732, ; 498: System.Core => 0x98f9bc61168392ac => 21
	i64 11037814507248023548, ; 499: System.Xml => 0x992e31d0412bf7fc => 163
	i64 11047101296015504039, ; 500: Microsoft.Win32.SystemEvents => 0x994f301942c2f2a7 => 213
	i64 11071824625609515081, ; 501: Xamarin.Google.ErrorProne.Annotations => 0x99a705d600e0a049 => 344
	i64 11128133081269842136, ; 502: vi/Microsoft.Maui.Controls.resources => 0x9a6f1213fa5cb0d8 => 412
	i64 11136029745144976707, ; 503: Jsr305Binding.dll => 0x9a8b200d4f8cd543 => 341
	i64 11150130305267896488, ; 504: zh-Hans/Microsoft.Maui.Controls.resources => 0x9abd386fcccf90a8 => 414
	i64 11162124722117608902, ; 505: Xamarin.AndroidX.ViewPager => 0x9ae7d54b986d05c6 => 305
	i64 11171845786728836392, ; 506: Xamarin.GooglePlayServices.CloudMessaging.dll => 0x9b0a5e8d536aad28 => 355
	i64 11188319605227840848, ; 507: System.Threading.Overlapped => 0x9b44e5671724e550 => 140
	i64 11226290749488709958, ; 508: Microsoft.Extensions.Options.dll => 0x9bcbcbf50c874146 => 200
	i64 11235648312900863002, ; 509: System.Reflection.DispatchProxy.dll => 0x9bed0a9c8fac441a => 89
	i64 11326322297822330275, ; 510: Google.Cloud.Firestore => 0x9d2f2e1ed5493da3 => 182
	i64 11329751333533450475, ; 511: System.Threading.Timer.dll => 0x9d3b5ccf6cc500eb => 147
	i64 11336891506707244397, ; 512: Xamarin.Firebase.Datatransport => 0x9d54bac28a6da56d => 321
	i64 11340910727871153756, ; 513: Xamarin.AndroidX.CursorAdapter => 0x9d630238642d465c => 261
	i64 11341245327015630248, ; 514: System.Configuration.ConfigurationManager.dll => 0x9d643289535355a8 => 230
	i64 11347436699239206956, ; 515: System.Xml.XmlSerializer.dll => 0x9d7a318e8162502c => 162
	i64 11361951459766490322, ; 516: Xamarin.GoogleAndroid.Annotations => 0x9dadc2a78a9cd4d2 => 348
	i64 11376351552967644903, ; 517: Xamarin.Firebase.Annotations.dll => 0x9de0eb76829996e7 => 312
	i64 11392833485892708388, ; 518: Xamarin.AndroidX.Print.dll => 0x9e1b79b18fcf6824 => 290
	i64 11432101114902388181, ; 519: System.AppContext => 0x9ea6fb64e61a9dd5 => 6
	i64 11435314654401632883, ; 520: Grpc.Core.Api => 0x9eb266175e6d9a73 => 189
	i64 11441445377436144712, ; 521: Grpc.Net.Common.dll => 0x9ec82df38f1dd448 => 191
	i64 11446671985764974897, ; 522: Mono.Android.Export => 0x9edabf8623efc131 => 169
	i64 11448276831755070604, ; 523: System.Diagnostics.TextWriterTraceListener => 0x9ee0731f77186c8c => 31
	i64 11485890710487134646, ; 524: System.Runtime.InteropServices => 0x9f6614bf0f8b71b6 => 107
	i64 11496466075493495264, ; 525: Xamarin.Grpc.Context.dll => 0x9f8ba6fc1a1e71e0 => 367
	i64 11508496261504176197, ; 526: Xamarin.AndroidX.Fragment.Ktx.dll => 0x9fb664600dde1045 => 271
	i64 11517440453979132662, ; 527: Microsoft.IdentityModel.Abstractions.dll => 0x9fd62b122523d2f6 => 202
	i64 11529969570048099689, ; 528: Xamarin.AndroidX.ViewPager.dll => 0xa002ae3c4dc7c569 => 305
	i64 11530571088791430846, ; 529: Microsoft.Extensions.Logging => 0xa004d1504ccd66be => 197
	i64 11543207250219725293, ; 530: Grpc.Net.Client => 0xa031b5d5e60f71ed => 190
	i64 11543422055205009205, ; 531: Xamarin.Firebase.Firestore => 0xa032793314e77735 => 326
	i64 11580057168383206117, ; 532: Xamarin.AndroidX.Annotation => 0xa0b4a0a4103262e5 => 244
	i64 11591352189662810718, ; 533: Xamarin.AndroidX.Startup.StartupRuntime.dll => 0xa0dcc167234c525e => 298
	i64 11597940890313164233, ; 534: netstandard => 0xa0f429ca8d1805c9 => 167
	i64 11672361001936329215, ; 535: Xamarin.AndroidX.Interpolator => 0xa1fc8e7d0a8999ff => 272
	i64 11692977985522001935, ; 536: System.Threading.Overlapped.dll => 0xa245cd869980680f => 140
	i64 11705530742807338875, ; 537: he/Microsoft.Maui.Controls.resources.dll => 0xa272663128721f7b => 391
	i64 11707295265961861272, ; 538: Plugin.Firebase.Crashlytics.dll => 0xa278ab043844e098 => 220
	i64 11707554492040141440, ; 539: System.Linq.Parallel.dll => 0xa27996c7fe94da80 => 59
	i64 11743665907891708234, ; 540: System.Threading.Tasks => 0xa2f9e1ec30c0214a => 144
	i64 11845716948639519119, ; 541: Xamarin.Firebase.Config => 0xa46470cdb17b918f => 318
	i64 11855946309386773903, ; 542: Xamarin.Google.Dagger => 0xa488c85a571a258f => 343
	i64 11864794479965678424, ; 543: Xamarin.Protobuf.JavaLite.dll => 0xa4a837b7975eab58 => 381
	i64 11888774080858266727, ; 544: hu/Microsoft.Maui.Controls.resources => 0xa4fd6909806d9c67 => 394
	i64 11991047634523762324, ; 545: System.Net => 0xa668c24ad493ae94 => 81
	i64 12010362171126083089, ; 546: Plugin.Firebase.CloudMessaging.dll => 0xa6ad60c2d1c26e11 => 218
	i64 12011556116648931059, ; 547: System.Security.Cryptography.ProtectedData => 0xa6b19ea5ec87aef3 => 235
	i64 12013962889899020729, ; 548: Xamarin.GooglePlayServices.Auth => 0xa6ba2b987d2811b9 => 350
	i64 12040886584167504988, ; 549: System.Net.ServicePoint => 0xa719d28d8e121c5c => 74
	i64 12063623837170009990, ; 550: System.Security => 0xa76a99f6ce740786 => 130
	i64 12096697103934194533, ; 551: System.Diagnostics.Contracts => 0xa7e019eccb7e8365 => 25
	i64 12102847907131387746, ; 552: System.Buffers => 0xa7f5f40c43256f62 => 7
	i64 12123043025855404482, ; 553: System.Reflection.Extensions.dll => 0xa83db366c0e359c2 => 93
	i64 12124060477258521817, ; 554: id/Microsoft.Maui.Controls.resources => 0xa84150c49e58dcd9 => 395
	i64 12130675990699684169, ; 555: Plugin.Firebase.Functions => 0xa858d18adf03b149 => 223
	i64 12137774235383566651, ; 556: Xamarin.AndroidX.VectorDrawable => 0xa872095bbfed113b => 302
	i64 12145679461940342714, ; 557: System.Text.Json => 0xa88e1f1ebcb62fba => 137
	i64 12191646537372739477, ; 558: Xamarin.Android.Glide.dll => 0xa9316dee7f392795 => 238
	i64 12199822034229429413, ; 559: Plugin.Firebase.Firestore => 0xa94e7980b13a84a5 => 222
	i64 12201331334810686224, ; 560: System.Runtime.Serialization.Primitives.dll => 0xa953d6341e3bd310 => 113
	i64 12269460666702402136, ; 561: System.Collections.Immutable.dll => 0xaa45e178506c9258 => 9
	i64 12332222936682028543, ; 562: System.Runtime.Handles => 0xab24db6c07db5dff => 104
	i64 12336928085371509187, ; 563: Xamarin.GooglePlayServices.Auth.Api.Phone => 0xab3592bad41bd9c3 => 351
	i64 12346958216201575315, ; 564: Xamarin.JavaX.Inject.dll => 0xab593514a5491b93 => 373
	i64 12375446203996702057, ; 565: System.Configuration.dll => 0xabbe6ac12e2e0569 => 19
	i64 12437742355241350664, ; 566: Google.Apis.dll => 0xac9bbcc62bfdb608 => 179
	i64 12439275739440478309, ; 567: Microsoft.IdentityModel.JsonWebTokens => 0xaca12f61007bf865 => 203
	i64 12451044538927396471, ; 568: Xamarin.AndroidX.Fragment.dll => 0xaccaff0a2955b677 => 270
	i64 12466513435562512481, ; 569: Xamarin.AndroidX.Loader.dll => 0xad01f3eb52569061 => 284
	i64 12475113361194491050, ; 570: _Microsoft.Android.Resource.Designer.dll => 0xad2081818aba1caa => 416
	i64 12487638416075308985, ; 571: Xamarin.AndroidX.DocumentFile.dll => 0xad4d00fa21b0bfb9 => 264
	i64 12517810545449516888, ; 572: System.Diagnostics.TraceSource.dll => 0xadb8325e6f283f58 => 33
	i64 12528155905152483962, ; 573: Firebase.Auth => 0xaddcf36b3153827a => 173
	i64 12533156002265635263, ; 574: ru/Microsoft.Maui.Controls.resources => 0xadeeb6fb059919bf => 406
	i64 12538491095302438457, ; 575: Xamarin.AndroidX.CardView.dll => 0xae01ab382ae67e39 => 252
	i64 12550732019250633519, ; 576: System.IO.Compression => 0xae2d28465e8e1b2f => 46
	i64 12681088699309157496, ; 577: it/Microsoft.Maui.Controls.resources.dll => 0xaffc46fc178aec78 => 396
	i64 12699999919562409296, ; 578: System.Diagnostics.StackTrace.dll => 0xb03f76a3ad01c550 => 30
	i64 12700543734426720211, ; 579: Xamarin.AndroidX.Collection => 0xb041653c70d157d3 => 253
	i64 12708238894395270091, ; 580: System.IO => 0xb05cbbf17d3ba3cb => 57
	i64 12708922737231849740, ; 581: System.Text.Encoding.Extensions => 0xb05f29e50e96e90c => 134
	i64 12717050818822477433, ; 582: System.Runtime.Serialization.Xml.dll => 0xb07c0a5786811679 => 114
	i64 12722065664929968482, ; 583: Google.Api.Gax.Rest.dll => 0xb08ddb515f583162 => 178
	i64 12753841065332862057, ; 584: Xamarin.AndroidX.Window => 0xb0febee04cf46c69 => 307
	i64 12823819093633476069, ; 585: th/Microsoft.Maui.Controls.resources.dll => 0xb1f75b85abe525e5 => 409
	i64 12828192437253469131, ; 586: Xamarin.Kotlin.StdLib.Jdk8.dll => 0xb206e50e14d873cb => 378
	i64 12835242264250840079, ; 587: System.IO.Pipes => 0xb21ff0d5d6c0740f => 55
	i64 12843321153144804894, ; 588: Microsoft.Extensions.Primitives => 0xb23ca48abd74d61e => 201
	i64 12843770487262409629, ; 589: System.AppContext.dll => 0xb23e3d357debf39d => 6
	i64 12845046283116214416, ; 590: Xamarin.Firebase.Analytics => 0xb242c589dc97f890 => 311
	i64 12854524964145442905, ; 591: Xamarin.Firebase.Encoders.dll => 0xb26472594447b059 => 323
	i64 12859557719246324186, ; 592: System.Net.WebHeaderCollection.dll => 0xb276539ce04f41da => 77
	i64 12958614573187252691, ; 593: Google.Apis => 0xb3d63f4bf006c1d3 => 179
	i64 12963446364377008305, ; 594: System.Drawing.Common.dll => 0xb3e769c8fd8548b1 => 231
	i64 12982280885948128408, ; 595: Xamarin.AndroidX.CustomView.PoolingContainer => 0xb42a53aec5481c98 => 263
	i64 13068258254871114833, ; 596: System.Runtime.Serialization.Formatters.dll => 0xb55bc7a4eaa8b451 => 111
	i64 13084382143907087733, ; 597: Xamarin.Grpc.Context => 0xb595103c610bc575 => 367
	i64 13121372212744448808, ; 598: Xamarin.Firebase.Abt => 0xb6187a81ea506b28 => 310
	i64 13129914918964716986, ; 599: Xamarin.AndroidX.Emoji2.dll => 0xb636d40db3fe65ba => 267
	i64 13162471042547327635, ; 600: System.Security.Permissions => 0xb6aa7dace9662293 => 236
	i64 13173818576982874404, ; 601: System.Runtime.CompilerServices.VisualC.dll => 0xb6d2ce32a8819924 => 102
	i64 13221551921002590604, ; 602: ca/Microsoft.Maui.Controls.resources.dll => 0xb77c636bdebe318c => 383
	i64 13222659110913276082, ; 603: ja/Microsoft.Maui.Controls.resources.dll => 0xb78052679c1178b2 => 397
	i64 13239674268801700939, ; 604: ca/Microsoft.Maui.Controls.resources => 0xb7bcc599c5ce144b => 383
	i64 13343850469010654401, ; 605: Mono.Android.Runtime.dll => 0xb92ee14d854f44c1 => 170
	i64 13370592475155966277, ; 606: System.Runtime.Serialization => 0xb98de304062ea945 => 115
	i64 13401370062847626945, ; 607: Xamarin.AndroidX.VectorDrawable.dll => 0xb9fb3b1193964ec1 => 302
	i64 13402939433517888790, ; 608: Xamarin.Google.Guava.FailureAccess => 0xba00ce6728e8b516 => 346
	i64 13404347523447273790, ; 609: Xamarin.AndroidX.ConstraintLayout.Core => 0xba05cf0da4f6393e => 257
	i64 13431476299110033919, ; 610: System.Net.WebClient => 0xba663087f18829ff => 76
	i64 13454009404024712428, ; 611: Xamarin.Google.Guava.ListenableFuture => 0xbab63e4543a86cec => 347
	i64 13463706743370286408, ; 612: System.Private.DataContractSerialization.dll => 0xbad8b1f3069e0548 => 85
	i64 13465488254036897740, ; 613: Xamarin.Kotlin.StdLib => 0xbadf06394d106fcc => 375
	i64 13467053111158216594, ; 614: uk/Microsoft.Maui.Controls.resources.dll => 0xbae49573fde79792 => 411
	i64 13491513212026656886, ; 615: Xamarin.AndroidX.Arch.Core.Runtime.dll => 0xbb3b7bc905569876 => 250
	i64 13545416393490209236, ; 616: id/Microsoft.Maui.Controls.resources.dll => 0xbbfafc7174bc99d4 => 395
	i64 13572454107664307259, ; 617: Xamarin.AndroidX.RecyclerView.dll => 0xbc5b0b19d99f543b => 292
	i64 13578472628727169633, ; 618: System.Xml.XPath => 0xbc706ce9fba5c261 => 160
	i64 13580399111273692417, ; 619: Microsoft.VisualBasic.Core.dll => 0xbc77450a277fbd01 => 2
	i64 13609095008681508810, ; 620: Xamarin.Grpc.Protobuf.Lite => 0xbcdd37ce6b00bfca => 370
	i64 13621154251410165619, ; 621: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 0xbd080f9faa1acf73 => 263
	i64 13647894001087880694, ; 622: System.Data.dll => 0xbd670f48cb071df6 => 24
	i64 13675589307506966157, ; 623: Xamarin.AndroidX.Activity.Ktx => 0xbdc97404d0153e8d => 243
	i64 13702626353344114072, ; 624: System.Diagnostics.Tools.dll => 0xbe29821198fb6d98 => 32
	i64 13710614125866346983, ; 625: System.Security.AccessControl.dll => 0xbe45e2e7d0b769e7 => 117
	i64 13713329104121190199, ; 626: System.Dynamic.Runtime => 0xbe4f8829f32b5737 => 37
	i64 13717397318615465333, ; 627: System.ComponentModel.Primitives.dll => 0xbe5dfc2ef2f87d75 => 16
	i64 13755568601956062840, ; 628: fr/Microsoft.Maui.Controls.resources.dll => 0xbee598c36b1b9678 => 390
	i64 13761131323945450492, ; 629: Xamarin.Firebase.Storage => 0xbef95c078f44fbfc => 335
	i64 13768883594457632599, ; 630: System.IO.IsolatedStorage => 0xbf14e6adb159cf57 => 52
	i64 13782512541859110153, ; 631: Google.Apis.Auth.dll => 0xbf45522249e0dd09 => 180
	i64 13814445057219246765, ; 632: hr/Microsoft.Maui.Controls.resources.dll => 0xbfb6c49664b43aad => 393
	i64 13828521679616088467, ; 633: Xamarin.Kotlin.StdLib.Common => 0xbfe8c733724e1993 => 376
	i64 13829530607229561650, ; 634: Xamarin.Firebase.Installations.InterOp => 0xbfec5cd0b64f6b32 => 331
	i64 13865727802090930648, ; 635: Xamarin.Google.Guava.dll => 0xc06cf5f8e3e341d8 => 345
	i64 13881769479078963060, ; 636: System.Console.dll => 0xc0a5f3cade5c6774 => 20
	i64 13882652712560114096, ; 637: System.Windows.Extensions.dll => 0xc0a91716b04239b0 => 237
	i64 13911222732217019342, ; 638: System.Security.Cryptography.OpenSsl.dll => 0xc10e975ec1226bce => 123
	i64 13928444506500929300, ; 639: System.Windows.dll => 0xc14bc67b8bba9714 => 154
	i64 13959074834287824816, ; 640: Xamarin.AndroidX.Fragment => 0xc1b8989a7ad20fb0 => 270
	i64 13975254687929967048, ; 641: Xamarin.Google.Guava => 0xc1f2141837ada1c8 => 345
	i64 14075334701871371868, ; 642: System.ServiceModel.Web.dll => 0xc355a25647c5965c => 131
	i64 14100563506285742564, ; 643: da/Microsoft.Maui.Controls.resources.dll => 0xc3af43cd0cff89e4 => 385
	i64 14124974489674258913, ; 644: Xamarin.AndroidX.CardView => 0xc405fd76067d19e1 => 252
	i64 14125464355221830302, ; 645: System.Threading.dll => 0xc407bafdbc707a9e => 148
	i64 14165531176311179688, ; 646: Xamarin.Firebase.Auth => 0xc496138d7abfc9a8 => 314
	i64 14178052285788134900, ; 647: Xamarin.Android.Glide.Annotations.dll => 0xc4c28f6f75511df4 => 239
	i64 14212104595480609394, ; 648: System.Security.Cryptography.Cng.dll => 0xc53b89d4a4518272 => 120
	i64 14220608275227875801, ; 649: System.Diagnostics.FileVersionInfo.dll => 0xc559bfe1def019d9 => 28
	i64 14226382999226559092, ; 650: System.ServiceProcess => 0xc56e43f6938e2a74 => 132
	i64 14232023429000439693, ; 651: System.Resources.Writer.dll => 0xc5824de7789ba78d => 100
	i64 14254574811015963973, ; 652: System.Text.Encoding.Extensions.dll => 0xc5d26c4442d66545 => 134
	i64 14261073672896646636, ; 653: Xamarin.AndroidX.Print => 0xc5e982f274ae0dec => 290
	i64 14298246716367104064, ; 654: System.Web.dll => 0xc66d93a217f4e840 => 153
	i64 14327695147300244862, ; 655: System.Reflection.dll => 0xc6d632d338eb4d7e => 97
	i64 14327709162229390963, ; 656: System.Security.Cryptography.X509Certificates => 0xc6d63f9253cade73 => 125
	i64 14331727281556788554, ; 657: Xamarin.Android.Glide.DiskLruCache.dll => 0xc6e48607a2f7954a => 240
	i64 14346402571976470310, ; 658: System.Net.Ping.dll => 0xc718a920f3686f26 => 69
	i64 14382082037123372364, ; 659: Xamarin.Firebase.Auth.Interop => 0xc7976b69c943d54c => 315
	i64 14461014870687870182, ; 660: System.Net.Requests.dll => 0xc8afd8683afdece6 => 72
	i64 14486659737292545672, ; 661: Xamarin.AndroidX.Lifecycle.LiveData => 0xc90af44707469e88 => 275
	i64 14495724990987328804, ; 662: Xamarin.AndroidX.ResourceInspection.Annotation => 0xc92b2913e18d5d24 => 293
	i64 14522721392235705434, ; 663: el/Microsoft.Maui.Controls.resources.dll => 0xc98b12295c2cf45a => 387
	i64 14524915121004231475, ; 664: Xamarin.JavaX.Inject => 0xc992dd58a4283b33 => 373
	i64 14551742072151931844, ; 665: System.Text.Encodings.Web.dll => 0xc9f22c50f1b8fbc4 => 136
	i64 14561513370130550166, ; 666: System.Security.Cryptography.Primitives.dll => 0xca14e3428abb8d96 => 124
	i64 14574160591280636898, ; 667: System.Net.Quic => 0xca41d1d72ec783e2 => 71
	i64 14622043554576106986, ; 668: System.Runtime.Serialization.Formatters => 0xcaebef2458cc85ea => 111
	i64 14644440854989303794, ; 669: Xamarin.AndroidX.LocalBroadcastManager.dll => 0xcb3b815e37daeff2 => 285
	i64 14650706219563630045, ; 670: Grpc.Auth => 0xcb51c3af15b23ddd => 188
	i64 14669215534098758659, ; 671: Microsoft.Extensions.DependencyInjection.dll => 0xcb9385ceb3993c03 => 195
	i64 14671188939680189912, ; 672: Xamarin.Grpc.Core => 0xcb9a889bfe470dd8 => 368
	i64 14690985099581930927, ; 673: System.Web.HttpUtility => 0xcbe0dd1ca5233daf => 152
	i64 14698606024688292729, ; 674: Xamarin.Io.PerfMark.PerfMarkApi => 0xcbfbf04d8af65379 => 372
	i64 14786806131582421479, ; 675: Plugin.Firebase.dll => 0xcd3549d53389c9e7 => 215
	i64 14789919016435397935, ; 676: Xamarin.Firebase.Common.dll => 0xcd4058fc2f6d352f => 316
	i64 14792063746108907174, ; 677: Xamarin.Google.Guava.ListenableFuture.dll => 0xcd47f79af9c15ea6 => 347
	i64 14809388726477333247, ; 678: Xamarin.GooglePlayServices.Stats.dll => 0xcd8584954e5b22ff => 363
	i64 14820020068193622728, ; 679: Xamarin.Firebase.Abt.dll => 0xcdab49bb70d75ac8 => 310
	i64 14832630590065248058, ; 680: System.Security.Claims => 0xcdd816ef5d6e873a => 118
	i64 14852515768018889994, ; 681: Xamarin.AndroidX.CursorAdapter.dll => 0xce1ebc6625a76d0a => 261
	i64 14889905118082851278, ; 682: GoogleGson.dll => 0xcea391d0969961ce => 187
	i64 14892012299694389861, ; 683: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xceab0e490a083a65 => 415
	i64 14912225920358050525, ; 684: System.Security.Principal.Windows => 0xcef2de7759506add => 127
	i64 14935719434541007538, ; 685: System.Text.Encoding.CodePages.dll => 0xcf4655b160b702b2 => 133
	i64 14954917835170835695, ; 686: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xcf8a8a895a82ecef => 196
	i64 14984936317414011727, ; 687: System.Net.WebHeaderCollection => 0xcff5302fe54ff34f => 77
	i64 14987728460634540364, ; 688: System.IO.Compression.dll => 0xcfff1ba06622494c => 46
	i64 14988210264188246988, ; 689: Xamarin.AndroidX.DocumentFile => 0xd000d1d307cddbcc => 264
	i64 15015154896917945444, ; 690: System.Net.Security.dll => 0xd0608bd33642dc64 => 73
	i64 15024878362326791334, ; 691: System.Net.Http.Json => 0xd0831743ebf0f4a6 => 63
	i64 15071021337266399595, ; 692: System.Resources.Reader.dll => 0xd127060e7a18a96b => 98
	i64 15076659072870671916, ; 693: System.ObjectModel.dll => 0xd13b0d8c1620662c => 84
	i64 15079074247967634472, ; 694: Stripe.net.dll => 0xd143a222dbd9f428 => 228
	i64 15097078878581906526, ; 695: Google.Api.Gax.Grpc.dll => 0xd183994097ed5c5e => 177
	i64 15115185479366240210, ; 696: System.IO.Compression.Brotli.dll => 0xd1c3ed1c1bc467d2 => 43
	i64 15133485256822086103, ; 697: System.Linq.dll => 0xd204f0a9127dd9d7 => 61
	i64 15138356091203993725, ; 698: Microsoft.IdentityModel.Abstractions => 0xd2163ea89395c07d => 202
	i64 15150743910298169673, ; 699: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 0xd2424150783c3149 => 291
	i64 15227001540531775957, ; 700: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd3512d3999b8e9d5 => 194
	i64 15234786388537674379, ; 701: System.Dynamic.Runtime.dll => 0xd36cd580c5be8a8b => 37
	i64 15250465174479574862, ; 702: System.Globalization.Calendars.dll => 0xd3a489469852174e => 40
	i64 15272359115529052076, ; 703: Xamarin.AndroidX.Collection.Ktx => 0xd3f251b2fb4edfac => 254
	i64 15273147323526128252, ; 704: de/Microsoft.Maui.Controls.resources => 0xd3f51e91f4fba27c => 386
	i64 15279429628684179188, ; 705: Xamarin.KotlinX.Coroutines.Android.dll => 0xd40b704b1c4c96f4 => 379
	i64 15299439993936780255, ; 706: System.Xml.XPath.dll => 0xd452879d55019bdf => 160
	i64 15338463749992804988, ; 707: System.Resources.Reader => 0xd4dd2b839286f27c => 98
	i64 15370334346939861994, ; 708: Xamarin.AndroidX.Core.dll => 0xd54e65a72c560bea => 259
	i64 15391712275433856905, ; 709: Microsoft.Extensions.DependencyInjection.Abstractions => 0xd59a58c406411f89 => 196
	i64 15443314347085689186, ; 710: nl/Microsoft.Maui.Controls.resources => 0xd651ac9394bc7162 => 401
	i64 15474781042002767710, ; 711: hr/Microsoft.Maui.Controls.resources => 0xd6c1775e69862f5e => 393
	i64 15478373401424648762, ; 712: es/Microsoft.Maui.Controls.resources => 0xd6ce3a99c4c55a3a => 388
	i64 15526743539506359484, ; 713: System.Text.Encoding.dll => 0xd77a12fc26de2cbc => 135
	i64 15527772828719725935, ; 714: System.Console => 0xd77dbb1e38cd3d6f => 20
	i64 15530465045505749832, ; 715: System.Net.HttpListener.dll => 0xd7874bacc9fdb348 => 65
	i64 15541854775306130054, ; 716: System.Security.Cryptography.X509Certificates.dll => 0xd7afc292e8d49286 => 125
	i64 15557562860424774966, ; 717: System.Net.Sockets => 0xd7e790fe7a6dc536 => 75
	i64 15582737692548360875, ; 718: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xd841015ed86f6aab => 283
	i64 15609085926864131306, ; 719: System.dll => 0xd89e9cf3334914ea => 164
	i64 15661133872274321916, ; 720: System.Xml.ReaderWriter.dll => 0xd9578647d4bfb1fc => 156
	i64 15664356999916475676, ; 721: de/Microsoft.Maui.Controls.resources.dll => 0xd962f9b2b6ecd51c => 386
	i64 15710114879900314733, ; 722: Microsoft.Win32.Registry => 0xda058a3f5d096c6d => 5
	i64 15743187114543869802, ; 723: hu/Microsoft.Maui.Controls.resources.dll => 0xda7b09450ae4ef6a => 394
	i64 15755368083429170162, ; 724: System.IO.FileSystem.Primitives => 0xdaa64fcbde529bf2 => 49
	i64 15777549416145007739, ; 725: Xamarin.AndroidX.SlidingPaneLayout.dll => 0xdaf51d99d77eb47b => 297
	i64 15788897513097211459, ; 726: Xamarin.Firebase.ProtoliteWellKnownTypes.dll => 0xdb1d6ea28f352e43 => 334
	i64 15817206913877585035, ; 727: System.Threading.Tasks.dll => 0xdb8201e29086ac8b => 144
	i64 15847085070278954535, ; 728: System.Threading.Channels.dll => 0xdbec27e8f35f8e27 => 139
	i64 15885744048853936810, ; 729: System.Resources.Writer => 0xdc75800bd0b6eaaa => 100
	i64 15928521404965645318, ; 730: Microsoft.Maui.Controls.Compatibility => 0xdd0d79d32c2eec06 => 206
	i64 15930129725311349754, ; 731: Xamarin.GooglePlayServices.Tasks.dll => 0xdd1330956f12f3fa => 364
	i64 15934062614519587357, ; 732: System.Security.Cryptography.OpenSsl => 0xdd2129868f45a21d => 123
	i64 15937190497610202713, ; 733: System.Security.Cryptography.Cng => 0xdd2c465197c97e59 => 120
	i64 15963349826457351533, ; 734: System.Threading.Tasks.Extensions => 0xdd893616f748b56d => 142
	i64 15971679995444160383, ; 735: System.Formats.Tar.dll => 0xdda6ce5592a9677f => 39
	i64 15995174293784908801, ; 736: nb/Microsoft.Maui.Controls.resources => 0xddfa46462d825401 => 400
	i64 16018552496348375205, ; 737: System.Net.NetworkInformation.dll => 0xde4d54a020caa8a5 => 68
	i64 16054465462676478687, ; 738: System.Globalization.Extensions => 0xdecceb47319bdadf => 41
	i64 16154507427712707110, ; 739: System => 0xe03056ea4e39aa26 => 164
	i64 16198848395322856833, ; 740: ms/Microsoft.Maui.Controls.resources => 0xe0cddeca55a01581 => 399
	i64 16219561732052121626, ; 741: System.Net.Security => 0xe1177575db7c781a => 73
	i64 16303230644352379770, ; 742: Xamarin.Grpc.OkHttp => 0xe240b5e48fe2eb7a => 369
	i64 16315482530584035869, ; 743: WindowsBase.dll => 0xe26c3ceb1e8d821d => 165
	i64 16321164108206115771, ; 744: Microsoft.Extensions.Logging.Abstractions.dll => 0xe2806c487e7b0bbb => 198
	i64 16337011941688632206, ; 745: System.Security.Principal.Windows.dll => 0xe2b8b9cdc3aa638e => 127
	i64 16361933716545543812, ; 746: Xamarin.AndroidX.ExifInterface.dll => 0xe3114406a52f1e84 => 269
	i64 16423015068819898779, ; 747: Xamarin.Kotlin.StdLib.Jdk8 => 0xe3ea453135e5c19b => 378
	i64 16454459195343277943, ; 748: System.Net.NetworkInformation => 0xe459fb756d988f77 => 68
	i64 16467346005009053642, ; 749: Xamarin.Google.Android.DataTransport.TransportApi => 0xe487c3f19e0337ca => 337
	i64 16491294355724214223, ; 750: zh-HK/Microsoft.Maui.Controls.resources => 0xe4dcd8d787589fcf => 413
	i64 16496768397145114574, ; 751: Mono.Android.Export.dll => 0xe4f04b741db987ce => 169
	i64 16579050217386591297, ; 752: Xamarin.Google.Guava.FailureAccess.dll => 0xe6149e5548b0c441 => 346
	i64 16589693266713801121, ; 753: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 0xe63a6e214f2a71a1 => 282
	i64 16621146507174665210, ; 754: Xamarin.AndroidX.ConstraintLayout => 0xe6aa2caf87dedbfa => 256
	i64 16649148416072044166, ; 755: Microsoft.Maui.Graphics => 0xe70da84600bb4e86 => 211
	i64 16677317093839702854, ; 756: Xamarin.AndroidX.Navigation.UI => 0xe771bb8960dd8b46 => 289
	i64 16702652415771857902, ; 757: System.ValueTuple => 0xe7cbbde0b0e6d3ee => 151
	i64 16709499819875633724, ; 758: System.IO.Compression.ZipFile => 0xe7e4118e32240a3c => 45
	i64 16737304880976948124, ; 759: ja/Microsoft.Maui.Controls.resources => 0xe846da1c780aeb9c => 397
	i64 16737807731308835127, ; 760: System.Runtime.Intrinsics => 0xe848a3736f733137 => 108
	i64 16758309481308491337, ; 761: System.IO.FileSystem.DriveInfo => 0xe89179af15740e49 => 48
	i64 16762783179241323229, ; 762: System.Reflection.TypeExtensions => 0xe8a15e7d0d927add => 96
	i64 16765015072123548030, ; 763: System.Diagnostics.TextWriterTraceListener.dll => 0xe8a94c621bfe717e => 31
	i64 16822611501064131242, ; 764: System.Data.DataSetExtensions => 0xe975ec07bb5412aa => 23
	i64 16833383113903931215, ; 765: mscorlib => 0xe99c30c1484d7f4f => 166
	i64 16856067890322379635, ; 766: System.Data.Common.dll => 0xe9ecc87060889373 => 22
	i64 16890310621557459193, ; 767: System.Text.RegularExpressions.dll => 0xea66700587f088f9 => 138
	i64 16933958494752847024, ; 768: System.Net.WebProxy.dll => 0xeb018187f0f3b4b0 => 78
	i64 16955525858597485057, ; 769: Google.Api.Gax => 0xeb4e20ef25a73a01 => 176
	i64 16977952268158210142, ; 770: System.IO.Pipes.AccessControl => 0xeb9dcda2851b905e => 54
	i64 16989020923549080504, ; 771: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 0xebc52084add25bb8 => 282
	i64 16991533501433402966, ; 772: Google.Api.CommonProtos.dll => 0xebce0db1ce165656 => 175
	i64 16998075588627545693, ; 773: Xamarin.AndroidX.Navigation.Fragment => 0xebe54bb02d623e5d => 287
	i64 17008137082415910100, ; 774: System.Collections.NonGeneric => 0xec090a90408c8cd4 => 10
	i64 17020682463616072225, ; 775: Xamarin.Firebase.Crashlytics => 0xec359c856e8e7a21 => 319
	i64 17024911836938395553, ; 776: Xamarin.AndroidX.Annotation.Experimental.dll => 0xec44a31d250e5fa1 => 245
	i64 17031351772568316411, ; 777: Xamarin.AndroidX.Navigation.Common.dll => 0xec5b843380a769fb => 286
	i64 17037200463775726619, ; 778: Xamarin.AndroidX.Legacy.Support.Core.Utils => 0xec704b8e0a78fc1b => 273
	i64 17062143951396181894, ; 779: System.ComponentModel.Primitives => 0xecc8e986518c9786 => 16
	i64 17089008752050867324, ; 780: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xed285aeb25888c7c => 414
	i64 17118171214553292978, ; 781: System.Threading.Channels => 0xed8ff6060fc420b2 => 139
	i64 17137864900836977098, ; 782: Microsoft.IdentityModel.Tokens => 0xedd5ed53b705e9ca => 205
	i64 17187273293601214786, ; 783: System.ComponentModel.Annotations.dll => 0xee8575ff9aa89142 => 13
	i64 17201328579425343169, ; 784: System.ComponentModel.EventBasedAsync => 0xeeb76534d96c16c1 => 15
	i64 17202182880784296190, ; 785: System.Security.Cryptography.Encoding.dll => 0xeeba6e30627428fe => 122
	i64 17230721278011714856, ; 786: System.Private.Xml.Linq => 0xef1fd1b5c7a72d28 => 87
	i64 17234219099804750107, ; 787: System.Transactions.Local.dll => 0xef2c3ef5e11d511b => 149
	i64 17260702271250283638, ; 788: System.Data.Common => 0xef8a5543bba6bc76 => 22
	i64 17310799966561153083, ; 789: Xamarin.GooglePlayServices.Auth.dll => 0xf03c50da60b8b03b => 350
	i64 17333249706306540043, ; 790: System.Diagnostics.Tracing.dll => 0xf08c12c5bb8b920b => 34
	i64 17338386382517543202, ; 791: System.Net.WebSockets.Client.dll => 0xf09e528d5c6da122 => 79
	i64 17360349973592121190, ; 792: Xamarin.Google.Crypto.Tink.Android => 0xf0ec5a52686b9f66 => 342
	i64 17434242208926550937, ; 793: Xamarin.Google.Android.DataTransport.TransportRuntime => 0xf1f2deeb1f304b99 => 339
	i64 17438153253682247751, ; 794: sk/Microsoft.Maui.Controls.resources.dll => 0xf200c3fe308d7847 => 407
	i64 17470386307322966175, ; 795: System.Threading.Timer => 0xf27347c8d0d5709f => 147
	i64 17482873938501421891, ; 796: fr/Microsoft.Maui.Controls.resources => 0xf29fa538054fcb43 => 390
	i64 17509662556995089465, ; 797: System.Net.WebSockets.dll => 0xf2fed1534ea67439 => 80
	i64 17522591619082469157, ; 798: GoogleGson => 0xf32cc03d27a5bf25 => 187
	i64 17523946658117960076, ; 799: System.Security.Cryptography.ProtectedData.dll => 0xf33190a3c403c18c => 235
	i64 17553799493972570483, ; 800: Google.Protobuf.dll => 0xf39b9fa2c0aab173 => 186
	i64 17580703809748094541, ; 801: Xamarin.GooglePlayServices.Measurement.Api => 0xf3fb34f7e9644e4d => 357
	i64 17590473451926037903, ; 802: Xamarin.Android.Glide => 0xf41dea67fcfda58f => 238
	i64 17605100189928655442, ; 803: Xamarin.Firebase.AppCheck.Interop => 0xf451e158cfdc0a52 => 313
	i64 17627500474728259406, ; 804: System.Globalization => 0xf4a176498a351f4e => 42
	i64 17677828421478984182, ; 805: Xamarin.Firebase.Installations.InterOp.dll => 0xf5544349c68f29f6 => 331
	i64 17685921127322830888, ; 806: System.Diagnostics.Debug.dll => 0xf571038fafa74828 => 26
	i64 17702523067201099846, ; 807: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xf5abfef008ae1846 => 413
	i64 17704177640604968747, ; 808: Xamarin.AndroidX.Loader => 0xf5b1dfc36cac272b => 284
	i64 17710060891934109755, ; 809: Xamarin.AndroidX.Lifecycle.ViewModel => 0xf5c6c68c9e45303b => 281
	i64 17712670374920797664, ; 810: System.Runtime.InteropServices.dll => 0xf5d00bdc38bd3de0 => 107
	i64 17743407583038752114, ; 811: System.CodeDom.dll => 0xf63d3f302bff4572 => 229
	i64 17777860260071588075, ; 812: System.Runtime.Numerics.dll => 0xf6b7a5b72419c0eb => 110
	i64 17790600151040787804, ; 813: Microsoft.IdentityModel.Logging => 0xf6e4e89427cc055c => 204
	i64 17838668724098252521, ; 814: System.Buffers.dll => 0xf78faeb0f5bf3ee9 => 7
	i64 17891337867145587222, ; 815: Xamarin.Jetbrains.Annotations => 0xf84accff6fb52a16 => 374
	i64 17928294245072900555, ; 816: System.IO.Compression.FileSystem.dll => 0xf8ce18a0b24011cb => 44
	i64 17945795017270165205, ; 817: Xamarin.Google.Android.DataTransport.TransportApi.dll => 0xf90c457cc05cfed5 => 337
	i64 17986907704309214542, ; 818: Xamarin.GooglePlayServices.Basement.dll => 0xf99e554223166d4e => 354
	i64 17992315986609351877, ; 819: System.Xml.XmlDocument.dll => 0xf9b18c0ffc6eacc5 => 161
	i64 18025913125965088385, ; 820: System.Threading => 0xfa28e87b91334681 => 148
	i64 18099568558057551825, ; 821: nl/Microsoft.Maui.Controls.resources.dll => 0xfb2e95b53ad977d1 => 401
	i64 18116111925905154859, ; 822: Xamarin.AndroidX.Arch.Core.Runtime => 0xfb695bd036cb632b => 250
	i64 18121036031235206392, ; 823: Xamarin.AndroidX.Navigation.Common => 0xfb7ada42d3d42cf8 => 286
	i64 18146411883821974900, ; 824: System.Formats.Asn1.dll => 0xfbd50176eb22c574 => 38
	i64 18146811631844267958, ; 825: System.ComponentModel.EventBasedAsync.dll => 0xfbd66d08820117b6 => 15
	i64 18225059387460068507, ; 826: System.Threading.ThreadPool.dll => 0xfcec6af3cff4a49b => 146
	i64 18245806341561545090, ; 827: System.Collections.Concurrent.dll => 0xfd3620327d587182 => 8
	i64 18260797123374478311, ; 828: Xamarin.AndroidX.Emoji2 => 0xfd6b623bde35f3e7 => 267
	i64 18305135509493619199, ; 829: Xamarin.AndroidX.Navigation.Runtime.dll => 0xfe08e7c2d8c199ff => 288
	i64 18318849532986632368, ; 830: System.Security.dll => 0xfe39a097c37fa8b0 => 130
	i64 18337470502355292274, ; 831: Xamarin.Firebase.Messaging => 0xfe7bc8440c175072 => 333
	i64 18380184030268848184, ; 832: Xamarin.AndroidX.VersionedParcelable => 0xff1387fe3e7b7838 => 304
	i64 18439108438687598470 ; 833: System.Reflection.Metadata.dll => 0xffe4df6e2ee1c786 => 94
], align 8

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [834 x i32] [
	i32 225, ; 0
	i32 266, ; 1
	i32 184, ; 2
	i32 201, ; 3
	i32 171, ; 4
	i32 210, ; 5
	i32 58, ; 6
	i32 253, ; 7
	i32 151, ; 8
	i32 294, ; 9
	i32 297, ; 10
	i32 260, ; 11
	i32 132, ; 12
	i32 56, ; 13
	i32 296, ; 14
	i32 360, ; 15
	i32 216, ; 16
	i32 234, ; 17
	i32 389, ; 18
	i32 95, ; 19
	i32 279, ; 20
	i32 129, ; 21
	i32 353, ; 22
	i32 231, ; 23
	i32 174, ; 24
	i32 145, ; 25
	i32 254, ; 26
	i32 18, ; 27
	i32 392, ; 28
	i32 265, ; 29
	i32 280, ; 30
	i32 150, ; 31
	i32 104, ; 32
	i32 95, ; 33
	i32 382, ; 34
	i32 340, ; 35
	i32 400, ; 36
	i32 372, ; 37
	i32 221, ; 38
	i32 36, ; 39
	i32 366, ; 40
	i32 28, ; 41
	i32 249, ; 42
	i32 320, ; 43
	i32 287, ; 44
	i32 315, ; 45
	i32 50, ; 46
	i32 115, ; 47
	i32 317, ; 48
	i32 365, ; 49
	i32 70, ; 50
	i32 207, ; 51
	i32 65, ; 52
	i32 170, ; 53
	i32 145, ; 54
	i32 398, ; 55
	i32 308, ; 56
	i32 248, ; 57
	i32 283, ; 58
	i32 273, ; 59
	i32 402, ; 60
	i32 40, ; 61
	i32 89, ; 62
	i32 81, ; 63
	i32 214, ; 64
	i32 66, ; 65
	i32 62, ; 66
	i32 86, ; 67
	i32 186, ; 68
	i32 247, ; 69
	i32 106, ; 70
	i32 294, ; 71
	i32 338, ; 72
	i32 102, ; 73
	i32 192, ; 74
	i32 35, ; 75
	i32 244, ; 76
	i32 296, ; 77
	i32 208, ; 78
	i32 365, ; 79
	i32 410, ; 80
	i32 119, ; 81
	i32 281, ; 82
	i32 228, ; 83
	i32 384, ; 84
	i32 368, ; 85
	i32 402, ; 86
	i32 142, ; 87
	i32 222, ; 88
	i32 141, ; 89
	i32 377, ; 90
	i32 53, ; 91
	i32 35, ; 92
	i32 141, ; 93
	i32 214, ; 94
	i32 398, ; 95
	i32 241, ; 96
	i32 251, ; 97
	i32 199, ; 98
	i32 265, ; 99
	i32 8, ; 100
	i32 14, ; 101
	i32 406, ; 102
	i32 293, ; 103
	i32 51, ; 104
	i32 276, ; 105
	i32 136, ; 106
	i32 101, ; 107
	i32 371, ; 108
	i32 385, ; 109
	i32 182, ; 110
	i32 258, ; 111
	i32 303, ; 112
	i32 384, ; 113
	i32 116, ; 114
	i32 242, ; 115
	i32 163, ; 116
	i32 205, ; 117
	i32 166, ; 118
	i32 67, ; 119
	i32 195, ; 120
	i32 80, ; 121
	i32 101, ; 122
	i32 298, ; 123
	i32 203, ; 124
	i32 181, ; 125
	i32 117, ; 126
	i32 230, ; 127
	i32 341, ; 128
	i32 320, ; 129
	i32 352, ; 130
	i32 78, ; 131
	i32 340, ; 132
	i32 0, ; 133
	i32 114, ; 134
	i32 404, ; 135
	i32 121, ; 136
	i32 48, ; 137
	i32 323, ; 138
	i32 227, ; 139
	i32 409, ; 140
	i32 213, ; 141
	i32 128, ; 142
	i32 274, ; 143
	i32 245, ; 144
	i32 82, ; 145
	i32 110, ; 146
	i32 75, ; 147
	i32 380, ; 148
	i32 316, ; 149
	i32 232, ; 150
	i32 354, ; 151
	i32 351, ; 152
	i32 210, ; 153
	i32 188, ; 154
	i32 53, ; 155
	i32 300, ; 156
	i32 193, ; 157
	i32 357, ; 158
	i32 69, ; 159
	i32 299, ; 160
	i32 83, ; 161
	i32 172, ; 162
	i32 116, ; 163
	i32 212, ; 164
	i32 194, ; 165
	i32 156, ; 166
	i32 193, ; 167
	i32 239, ; 168
	i32 167, ; 169
	i32 292, ; 170
	i32 266, ; 171
	i32 361, ; 172
	i32 349, ; 173
	i32 197, ; 174
	i32 32, ; 175
	i32 208, ; 176
	i32 183, ; 177
	i32 122, ; 178
	i32 72, ; 179
	i32 62, ; 180
	i32 161, ; 181
	i32 113, ; 182
	i32 370, ; 183
	i32 180, ; 184
	i32 88, ; 185
	i32 206, ; 186
	i32 224, ; 187
	i32 105, ; 188
	i32 18, ; 189
	i32 220, ; 190
	i32 146, ; 191
	i32 118, ; 192
	i32 58, ; 193
	i32 260, ; 194
	i32 17, ; 195
	i32 52, ; 196
	i32 324, ; 197
	i32 364, ; 198
	i32 92, ; 199
	i32 338, ; 200
	i32 216, ; 201
	i32 412, ; 202
	i32 55, ; 203
	i32 129, ; 204
	i32 359, ; 205
	i32 152, ; 206
	i32 41, ; 207
	i32 343, ; 208
	i32 92, ; 209
	i32 304, ; 210
	i32 50, ; 211
	i32 382, ; 212
	i32 317, ; 213
	i32 226, ; 214
	i32 162, ; 215
	i32 13, ; 216
	i32 278, ; 217
	i32 242, ; 218
	i32 299, ; 219
	i32 36, ; 220
	i32 67, ; 221
	i32 361, ; 222
	i32 389, ; 223
	i32 109, ; 224
	i32 224, ; 225
	i32 356, ; 226
	i32 243, ; 227
	i32 99, ; 228
	i32 184, ; 229
	i32 99, ; 230
	i32 11, ; 231
	i32 11, ; 232
	i32 285, ; 233
	i32 25, ; 234
	i32 352, ; 235
	i32 128, ; 236
	i32 76, ; 237
	i32 277, ; 238
	i32 371, ; 239
	i32 109, ; 240
	i32 303, ; 241
	i32 301, ; 242
	i32 106, ; 243
	i32 362, ; 244
	i32 219, ; 245
	i32 2, ; 246
	i32 26, ; 247
	i32 256, ; 248
	i32 157, ; 249
	i32 237, ; 250
	i32 21, ; 251
	i32 49, ; 252
	i32 43, ; 253
	i32 126, ; 254
	i32 246, ; 255
	i32 59, ; 256
	i32 336, ; 257
	i32 119, ; 258
	i32 181, ; 259
	i32 306, ; 260
	i32 269, ; 261
	i32 255, ; 262
	i32 3, ; 263
	i32 275, ; 264
	i32 356, ; 265
	i32 403, ; 266
	i32 295, ; 267
	i32 38, ; 268
	i32 124, ; 269
	i32 405, ; 270
	i32 322, ; 271
	i32 332, ; 272
	i32 295, ; 273
	i32 313, ; 274
	i32 366, ; 275
	i32 173, ; 276
	i32 137, ; 277
	i32 149, ; 278
	i32 85, ; 279
	i32 90, ; 280
	i32 328, ; 281
	i32 279, ; 282
	i32 416, ; 283
	i32 381, ; 284
	i32 276, ; 285
	i32 314, ; 286
	i32 225, ; 287
	i32 251, ; 288
	i32 215, ; 289
	i32 262, ; 290
	i32 363, ; 291
	i32 307, ; 292
	i32 200, ; 293
	i32 344, ; 294
	i32 277, ; 295
	i32 218, ; 296
	i32 133, ; 297
	i32 319, ; 298
	i32 96, ; 299
	i32 411, ; 300
	i32 349, ; 301
	i32 3, ; 302
	i32 105, ; 303
	i32 404, ; 304
	i32 33, ; 305
	i32 154, ; 306
	i32 158, ; 307
	i32 155, ; 308
	i32 339, ; 309
	i32 82, ; 310
	i32 178, ; 311
	i32 312, ; 312
	i32 234, ; 313
	i32 311, ; 314
	i32 271, ; 315
	i32 325, ; 316
	i32 143, ; 317
	i32 0, ; 318
	i32 87, ; 319
	i32 19, ; 320
	i32 272, ; 321
	i32 51, ; 322
	i32 327, ; 323
	i32 241, ; 324
	i32 408, ; 325
	i32 61, ; 326
	i32 54, ; 327
	i32 4, ; 328
	i32 97, ; 329
	i32 240, ; 330
	i32 17, ; 331
	i32 329, ; 332
	i32 396, ; 333
	i32 221, ; 334
	i32 324, ; 335
	i32 155, ; 336
	i32 84, ; 337
	i32 232, ; 338
	i32 212, ; 339
	i32 336, ; 340
	i32 217, ; 341
	i32 29, ; 342
	i32 185, ; 343
	i32 45, ; 344
	i32 405, ; 345
	i32 64, ; 346
	i32 66, ; 347
	i32 399, ; 348
	i32 359, ; 349
	i32 172, ; 350
	i32 280, ; 351
	i32 1, ; 352
	i32 375, ; 353
	i32 175, ; 354
	i32 47, ; 355
	i32 24, ; 356
	i32 248, ; 357
	i32 185, ; 358
	i32 330, ; 359
	i32 355, ; 360
	i32 330, ; 361
	i32 223, ; 362
	i32 326, ; 363
	i32 226, ; 364
	i32 165, ; 365
	i32 108, ; 366
	i32 12, ; 367
	i32 274, ; 368
	i32 63, ; 369
	i32 27, ; 370
	i32 23, ; 371
	i32 93, ; 372
	i32 168, ; 373
	i32 12, ; 374
	i32 379, ; 375
	i32 211, ; 376
	i32 29, ; 377
	i32 103, ; 378
	i32 233, ; 379
	i32 14, ; 380
	i32 126, ; 381
	i32 257, ; 382
	i32 289, ; 383
	i32 91, ; 384
	i32 278, ; 385
	i32 328, ; 386
	i32 333, ; 387
	i32 236, ; 388
	i32 387, ; 389
	i32 9, ; 390
	i32 410, ; 391
	i32 86, ; 392
	i32 407, ; 393
	i32 268, ; 394
	i32 301, ; 395
	i32 227, ; 396
	i32 309, ; 397
	i32 403, ; 398
	i32 71, ; 399
	i32 168, ; 400
	i32 1, ; 401
	i32 288, ; 402
	i32 5, ; 403
	i32 44, ; 404
	i32 177, ; 405
	i32 27, ; 406
	i32 318, ; 407
	i32 322, ; 408
	i32 376, ; 409
	i32 391, ; 410
	i32 158, ; 411
	i32 291, ; 412
	i32 112, ; 413
	i32 327, ; 414
	i32 362, ; 415
	i32 360, ; 416
	i32 335, ; 417
	i32 121, ; 418
	i32 219, ; 419
	i32 306, ; 420
	i32 247, ; 421
	i32 358, ; 422
	i32 190, ; 423
	i32 204, ; 424
	i32 159, ; 425
	i32 131, ; 426
	i32 342, ; 427
	i32 57, ; 428
	i32 138, ; 429
	i32 83, ; 430
	i32 30, ; 431
	i32 258, ; 432
	i32 10, ; 433
	i32 325, ; 434
	i32 321, ; 435
	i32 308, ; 436
	i32 329, ; 437
	i32 171, ; 438
	i32 255, ; 439
	i32 150, ; 440
	i32 94, ; 441
	i32 353, ; 442
	i32 392, ; 443
	i32 268, ; 444
	i32 60, ; 445
	i32 209, ; 446
	i32 229, ; 447
	i32 157, ; 448
	i32 388, ; 449
	i32 199, ; 450
	i32 64, ; 451
	i32 88, ; 452
	i32 191, ; 453
	i32 309, ; 454
	i32 79, ; 455
	i32 47, ; 456
	i32 207, ; 457
	i32 358, ; 458
	i32 143, ; 459
	i32 348, ; 460
	i32 174, ; 461
	i32 377, ; 462
	i32 408, ; 463
	i32 262, ; 464
	i32 74, ; 465
	i32 91, ; 466
	i32 183, ; 467
	i32 374, ; 468
	i32 332, ; 469
	i32 135, ; 470
	i32 90, ; 471
	i32 300, ; 472
	i32 380, ; 473
	i32 259, ; 474
	i32 192, ; 475
	i32 112, ; 476
	i32 42, ; 477
	i32 159, ; 478
	i32 4, ; 479
	i32 103, ; 480
	i32 70, ; 481
	i32 60, ; 482
	i32 176, ; 483
	i32 39, ; 484
	i32 217, ; 485
	i32 249, ; 486
	i32 189, ; 487
	i32 334, ; 488
	i32 153, ; 489
	i32 56, ; 490
	i32 233, ; 491
	i32 34, ; 492
	i32 369, ; 493
	i32 415, ; 494
	i32 198, ; 495
	i32 209, ; 496
	i32 246, ; 497
	i32 21, ; 498
	i32 163, ; 499
	i32 213, ; 500
	i32 344, ; 501
	i32 412, ; 502
	i32 341, ; 503
	i32 414, ; 504
	i32 305, ; 505
	i32 355, ; 506
	i32 140, ; 507
	i32 200, ; 508
	i32 89, ; 509
	i32 182, ; 510
	i32 147, ; 511
	i32 321, ; 512
	i32 261, ; 513
	i32 230, ; 514
	i32 162, ; 515
	i32 348, ; 516
	i32 312, ; 517
	i32 290, ; 518
	i32 6, ; 519
	i32 189, ; 520
	i32 191, ; 521
	i32 169, ; 522
	i32 31, ; 523
	i32 107, ; 524
	i32 367, ; 525
	i32 271, ; 526
	i32 202, ; 527
	i32 305, ; 528
	i32 197, ; 529
	i32 190, ; 530
	i32 326, ; 531
	i32 244, ; 532
	i32 298, ; 533
	i32 167, ; 534
	i32 272, ; 535
	i32 140, ; 536
	i32 391, ; 537
	i32 220, ; 538
	i32 59, ; 539
	i32 144, ; 540
	i32 318, ; 541
	i32 343, ; 542
	i32 381, ; 543
	i32 394, ; 544
	i32 81, ; 545
	i32 218, ; 546
	i32 235, ; 547
	i32 350, ; 548
	i32 74, ; 549
	i32 130, ; 550
	i32 25, ; 551
	i32 7, ; 552
	i32 93, ; 553
	i32 395, ; 554
	i32 223, ; 555
	i32 302, ; 556
	i32 137, ; 557
	i32 238, ; 558
	i32 222, ; 559
	i32 113, ; 560
	i32 9, ; 561
	i32 104, ; 562
	i32 351, ; 563
	i32 373, ; 564
	i32 19, ; 565
	i32 179, ; 566
	i32 203, ; 567
	i32 270, ; 568
	i32 284, ; 569
	i32 416, ; 570
	i32 264, ; 571
	i32 33, ; 572
	i32 173, ; 573
	i32 406, ; 574
	i32 252, ; 575
	i32 46, ; 576
	i32 396, ; 577
	i32 30, ; 578
	i32 253, ; 579
	i32 57, ; 580
	i32 134, ; 581
	i32 114, ; 582
	i32 178, ; 583
	i32 307, ; 584
	i32 409, ; 585
	i32 378, ; 586
	i32 55, ; 587
	i32 201, ; 588
	i32 6, ; 589
	i32 311, ; 590
	i32 323, ; 591
	i32 77, ; 592
	i32 179, ; 593
	i32 231, ; 594
	i32 263, ; 595
	i32 111, ; 596
	i32 367, ; 597
	i32 310, ; 598
	i32 267, ; 599
	i32 236, ; 600
	i32 102, ; 601
	i32 383, ; 602
	i32 397, ; 603
	i32 383, ; 604
	i32 170, ; 605
	i32 115, ; 606
	i32 302, ; 607
	i32 346, ; 608
	i32 257, ; 609
	i32 76, ; 610
	i32 347, ; 611
	i32 85, ; 612
	i32 375, ; 613
	i32 411, ; 614
	i32 250, ; 615
	i32 395, ; 616
	i32 292, ; 617
	i32 160, ; 618
	i32 2, ; 619
	i32 370, ; 620
	i32 263, ; 621
	i32 24, ; 622
	i32 243, ; 623
	i32 32, ; 624
	i32 117, ; 625
	i32 37, ; 626
	i32 16, ; 627
	i32 390, ; 628
	i32 335, ; 629
	i32 52, ; 630
	i32 180, ; 631
	i32 393, ; 632
	i32 376, ; 633
	i32 331, ; 634
	i32 345, ; 635
	i32 20, ; 636
	i32 237, ; 637
	i32 123, ; 638
	i32 154, ; 639
	i32 270, ; 640
	i32 345, ; 641
	i32 131, ; 642
	i32 385, ; 643
	i32 252, ; 644
	i32 148, ; 645
	i32 314, ; 646
	i32 239, ; 647
	i32 120, ; 648
	i32 28, ; 649
	i32 132, ; 650
	i32 100, ; 651
	i32 134, ; 652
	i32 290, ; 653
	i32 153, ; 654
	i32 97, ; 655
	i32 125, ; 656
	i32 240, ; 657
	i32 69, ; 658
	i32 315, ; 659
	i32 72, ; 660
	i32 275, ; 661
	i32 293, ; 662
	i32 387, ; 663
	i32 373, ; 664
	i32 136, ; 665
	i32 124, ; 666
	i32 71, ; 667
	i32 111, ; 668
	i32 285, ; 669
	i32 188, ; 670
	i32 195, ; 671
	i32 368, ; 672
	i32 152, ; 673
	i32 372, ; 674
	i32 215, ; 675
	i32 316, ; 676
	i32 347, ; 677
	i32 363, ; 678
	i32 310, ; 679
	i32 118, ; 680
	i32 261, ; 681
	i32 187, ; 682
	i32 415, ; 683
	i32 127, ; 684
	i32 133, ; 685
	i32 196, ; 686
	i32 77, ; 687
	i32 46, ; 688
	i32 264, ; 689
	i32 73, ; 690
	i32 63, ; 691
	i32 98, ; 692
	i32 84, ; 693
	i32 228, ; 694
	i32 177, ; 695
	i32 43, ; 696
	i32 61, ; 697
	i32 202, ; 698
	i32 291, ; 699
	i32 194, ; 700
	i32 37, ; 701
	i32 40, ; 702
	i32 254, ; 703
	i32 386, ; 704
	i32 379, ; 705
	i32 160, ; 706
	i32 98, ; 707
	i32 259, ; 708
	i32 196, ; 709
	i32 401, ; 710
	i32 393, ; 711
	i32 388, ; 712
	i32 135, ; 713
	i32 20, ; 714
	i32 65, ; 715
	i32 125, ; 716
	i32 75, ; 717
	i32 283, ; 718
	i32 164, ; 719
	i32 156, ; 720
	i32 386, ; 721
	i32 5, ; 722
	i32 394, ; 723
	i32 49, ; 724
	i32 297, ; 725
	i32 334, ; 726
	i32 144, ; 727
	i32 139, ; 728
	i32 100, ; 729
	i32 206, ; 730
	i32 364, ; 731
	i32 123, ; 732
	i32 120, ; 733
	i32 142, ; 734
	i32 39, ; 735
	i32 400, ; 736
	i32 68, ; 737
	i32 41, ; 738
	i32 164, ; 739
	i32 399, ; 740
	i32 73, ; 741
	i32 369, ; 742
	i32 165, ; 743
	i32 198, ; 744
	i32 127, ; 745
	i32 269, ; 746
	i32 378, ; 747
	i32 68, ; 748
	i32 337, ; 749
	i32 413, ; 750
	i32 169, ; 751
	i32 346, ; 752
	i32 282, ; 753
	i32 256, ; 754
	i32 211, ; 755
	i32 289, ; 756
	i32 151, ; 757
	i32 45, ; 758
	i32 397, ; 759
	i32 108, ; 760
	i32 48, ; 761
	i32 96, ; 762
	i32 31, ; 763
	i32 23, ; 764
	i32 166, ; 765
	i32 22, ; 766
	i32 138, ; 767
	i32 78, ; 768
	i32 176, ; 769
	i32 54, ; 770
	i32 282, ; 771
	i32 175, ; 772
	i32 287, ; 773
	i32 10, ; 774
	i32 319, ; 775
	i32 245, ; 776
	i32 286, ; 777
	i32 273, ; 778
	i32 16, ; 779
	i32 414, ; 780
	i32 139, ; 781
	i32 205, ; 782
	i32 13, ; 783
	i32 15, ; 784
	i32 122, ; 785
	i32 87, ; 786
	i32 149, ; 787
	i32 22, ; 788
	i32 350, ; 789
	i32 34, ; 790
	i32 79, ; 791
	i32 342, ; 792
	i32 339, ; 793
	i32 407, ; 794
	i32 147, ; 795
	i32 390, ; 796
	i32 80, ; 797
	i32 187, ; 798
	i32 235, ; 799
	i32 186, ; 800
	i32 357, ; 801
	i32 238, ; 802
	i32 313, ; 803
	i32 42, ; 804
	i32 331, ; 805
	i32 26, ; 806
	i32 413, ; 807
	i32 284, ; 808
	i32 281, ; 809
	i32 107, ; 810
	i32 229, ; 811
	i32 110, ; 812
	i32 204, ; 813
	i32 7, ; 814
	i32 374, ; 815
	i32 44, ; 816
	i32 337, ; 817
	i32 354, ; 818
	i32 161, ; 819
	i32 148, ; 820
	i32 401, ; 821
	i32 250, ; 822
	i32 286, ; 823
	i32 38, ; 824
	i32 15, ; 825
	i32 146, ; 826
	i32 8, ; 827
	i32 267, ; 828
	i32 288, ; 829
	i32 130, ; 830
	i32 333, ; 831
	i32 304, ; 832
	i32 94 ; 833
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" }

; Metadata
!llvm.module.flags = !{!0, !1, !7, !8, !9, !10}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ 82d8938cf80f6d5fa6c28529ddfbdb753d805ab4"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"branch-target-enforcement", i32 0}
!8 = !{i32 1, !"sign-return-address", i32 0}
!9 = !{i32 1, !"sign-return-address-all", i32 0}
!10 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
