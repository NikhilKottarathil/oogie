abstract class PageScrollStatus {
  const PageScrollStatus();
}

class InitialScrollStatus extends PageScrollStatus {
  const InitialScrollStatus();
}

class ScrollToTopStatus extends PageScrollStatus {}

class ScrollToBottomStatus extends PageScrollStatus {}

class ScrollingStatus extends PageScrollStatus {}

class IdleStatus extends PageScrollStatus {}

class LoadingMoreItemsStatus extends PageScrollStatus {}
