// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation

/// AudioKit version of Apple's ParametricEQ Audio Unit
///
open class ParametricEQ: Node {

    fileprivate let effectAU = AVAudioUnitEffect(appleEffect: kAudioUnitSubType_ParametricEQ)

    let input: Node
    public var connections: [Node] { [input] }
    public var avAudioNode: AVAudioNode { effectAU }

    /// Specification details for centerFreq
    public static let centerFreqDef = NodeParameterDef(
        identifier: "centerFreq",
        name: "Center Freq",
        address: 0,
        defaultValue: 2000,
        range: 20 ... 22050,
        unit: .hertz)

    /// Center Freq (Hertz) ranges from 20 to 22050 (Default: 2000)
    @Parameter(centerFreqDef) public var centerFreq: AUValue

    /// Specification details for q
    public static let qDef = NodeParameterDef(
        identifier: "q",
        name: "Q",
        address: 1,
        defaultValue: 1.0,
        range: 0.1 ... 20,
        unit: .hertz)

    /// Q (Hertz) ranges from 0.1 to 20 (Default: 1.0)
    @Parameter(qDef) public var q: AUValue

    /// Specification details for gain
    public static let gainDef = NodeParameterDef(
        identifier: "gain",
        name: "Gain",
        address: 2,
        defaultValue: 0,
        range: -20 ... 20,
        unit: .decibels)

    /// Gain (decibels) ranges from -20 to 20 (Default: 0)
    @Parameter(gainDef) public var gain: AUValue

    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Initialize the parametric eq node
    ///
    /// - parameter input: Input node to process
    /// - parameter centerFreq: Center Freq (Hertz) ranges from 20 to 22050 (Default: 2000)
    /// - parameter q: Q (Hertz) ranges from 0.1 to 20 (Default: 1.0)
    /// - parameter gain: Gain (decibels) ranges from -20 to 20 (Default: 0)
    ///
    public init(
        _ input: Node,
        centerFreq: AUValue = centerFreqDef.defaultValue,
        q: AUValue = qDef.defaultValue,
        gain: AUValue = gainDef.defaultValue) {
        self.input = input

        associateParams(with: effectAU)

        self.centerFreq = centerFreq
        self.q = q
        self.gain = gain
    }

    /// Function to start, play, or activate the node, all do the same thing
    public func start() {
        effectAU.bypass = false
        isStarted = true
    }

    /// Function to stop or bypass the node, both are equivalent
    public func stop() {
        effectAU.bypass = true
        isStarted = false
    }
}
