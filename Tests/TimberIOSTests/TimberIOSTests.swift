import Testing
@testable import TimberIOS


@Test func testDebugLogexEcutes() async throws {
    Timber.d("Debug Log")
    #expect(true)
}

@Test func testInfoLogExecutes() async throws {
    Timber.i("Debug Log")
    #expect(true)
}
