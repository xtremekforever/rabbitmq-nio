import NIO
import AMQPProtocol

public extension AMQPChannel {
    func basicPublish(body: ByteBuffer, exchange: String, routingKey: String, mandatory: Bool = false,  immediate: Bool = false, properties: Properties = Properties()) async throws {
        return try await self.basicPublish(body: body, exchange: exchange, routingKey: routingKey, mandatory: mandatory, immediate: immediate, properties: properties).get()
    }

    func basicPublish(body: [UInt8], exchange: String, routingKey: String, mandatory: Bool = false,  immediate: Bool = false, properties: Properties = Properties()) async throws  {
        return try await self.basicPublish(body: body, exchange: exchange, routingKey: routingKey, mandatory: mandatory, immediate: immediate, properties: properties).get()
    }

    func close(reason: String = "", code: UInt16 = 200) async throws {
        return try await self.close(reason: reason, code: code).get()
    }
}
