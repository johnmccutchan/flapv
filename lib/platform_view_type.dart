enum PlatformViewType {
  kBasic,
  kInput,
  kMap,
}

String platformViewTypeAsString(PlatformViewType viewType) {
  switch (viewType) {
    case PlatformViewType.kBasic:
      return 'static-text-view';
    case PlatformViewType.kInput:
      return 'input-grid-view';
    case PlatformViewType.kMap:
      return 'google-map-view';
  }
}

bool platformViewShouldHaveBanner(PlatformViewType viewType) {
  switch (viewType) {
    case PlatformViewType.kInput:
      return false;
    default:
      return true;
  }
}
