import NIOCore
import AMQPProtocol

internal struct BufferedFrameEncoder {
    private enum State {
        case flushed
        case writable
    }
    
    private var buffer: ByteBuffer
    private var state: State = .writable
    
    init(buffer: ByteBuffer) {
        self.buffer = buffer
    }

    @usableFromInline
    mutating func writeBytes(from bytes: [UInt8]) -> Int {
        self.prepare()
        return self.buffer.writeBytes(bytes)
    }
    
    @usableFromInline
    mutating func encode(_ frame: Frame) throws {
        self.prepare()
        do
        {
            try frame.encode(into: &self.buffer)
        }
        catch {
            self.buffer.clear()
            throw error
        }
    }
    
    @usableFromInline
    mutating func flush() -> ByteBuffer {
        self.state = .flushed
        return self.buffer
    }

    @usableFromInline
    mutating func prepare() {
        switch self.state {
        case .flushed:
            self.buffer.clear()
            self.state = .writable
        case .writable:
            break
        }
    }
}