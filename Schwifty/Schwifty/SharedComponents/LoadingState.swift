enum WidgetLoadingState<Content> {
    case empty
    case loading(placeholder: Content)
    case loaded(content: Content)
    case error(Error)
}
