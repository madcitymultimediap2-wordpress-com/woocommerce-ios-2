#if !targetEnvironment(macCatalyst)
import StripeTerminal

extension PaymentIntent {

    /// Convenience initializer
    /// - Parameter intent: An instance of a StripeTerminal.PaymentIntent
    init(intent: StripePaymentIntent) {
        self.id = intent.stripeId
        self.status = PaymentIntentStatus.with(status: intent.status)
        self.created = intent.created
        self.amount = intent.amount
        self.currency = intent.currency
        self.metadata = intent.metadata
        self.charges = intent.charges.map { .init(charge: $0) }
    }
}


/// The initializers of StripeTerminal.PaymentIntent are annotated as NS_UNAVAILABLE
/// So we can not create instances of that class in our tests.
/// A workaround is declaring this protocol, which matches the parts of
/// SCPPaymentIntent that we are interested in, make Reader implement it,
/// and initialize Harware.CardReader with a type conforming to it.
protocol StripePaymentIntent {
    var stripeId: String { get }
    var created: Date { get }
    var status: StripeTerminal.PaymentIntentStatus { get }
    var amount: UInt { get }
    var currency: String { get }
    var metadata: [String: String]? { get }
    var charges: [StripeTerminal.Charge] { get }
}


extension StripeTerminal.PaymentIntent: StripePaymentIntent { }
#endif
