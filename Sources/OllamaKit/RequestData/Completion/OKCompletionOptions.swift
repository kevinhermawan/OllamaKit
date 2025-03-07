//
//  OKCompletionData.swift
//
//
//  Created by Kevin Hermawan on 02/01/24.
//

import Foundation

// A structure that encapsulates options for controlling the behavior of content generation in the Ollama API.
public struct OKCompletionOptions: Encodable, Sendable {
    /// Optional integer to enable Mirostat sampling for controlling perplexity.
    /// (0 = disabled, 1 = Mirostat, 2 = Mirostat 2.0)
    /// Mirostat sampling helps regulate the unpredictability of the output,
    /// balancing coherence and diversity. The default value is 0, which disables Mirostat.
    public var mirostat: Int?
    
    /// Optional double influencing the adjustment speed of the Mirostat algorithm.
    /// (Lower values result in slower adjustments, higher values increase responsiveness.)
    /// This parameter, `mirostatEta`, adjusts how quickly the algorithm reacts to feedback
    /// from the generated text. A default value of 0.1 provides a moderate adjustment speed.
    public var mirostatEta: Float?
    
    /// Optional double controlling the balance between coherence and diversity.
    /// (Lower values lead to more focused and coherent text)
    /// The `mirostatTau` parameter sets the target perplexity level, influencing how
    /// creative or constrained the text generation should be. Default is 5.0.
    public var mirostatTau: Float?
    
    /// Optional integer setting the size of the context window for token generation.
    /// This defines the number of previous tokens the model considers when generating new tokens.
    /// Larger values allow the model to use more context, with a default of 2048 tokens.
    public var numCtx: Int?
    
    /// Optional integer setting how far back the model looks to prevent repetition.
    /// This parameter, `repeatLastN`, determines the number of tokens the model
    /// reviews to avoid repeating phrases. A value of 64 is typical, while 0 disables this feature.
    public var repeatLastN: Int?
    
    /// Optional double setting the penalty strength for repetitions.
    /// A higher value increases the penalty for repeated tokens, discouraging repetition.
    /// The default value is 1.1, providing moderate repetition control.
    public var repeatPenalty: Float?
    
    /// Optional double to control the model's creativity.
    /// (Higher values increase creativity and randomness)
    /// The `temperature` parameter adjusts the randomness of predictions; higher values
    /// like 0.8 make outputs more creative and diverse. The default is 0.7.
    public var temperature: Float?
    
    /// Optional integer for setting a random number seed for generation consistency.
    /// Specifying a seed ensures the same output for the same prompt and parameters,
    /// useful for testing or reproducing results. Default is 0, meaning no fixed seed.
    public var seed: Int?
    
    /// Optional string defining stop sequences for the model to cease generation.
    /// The `stop` parameter specifies sequences that, when encountered, will halt further text generation.
    /// Multiple stop sequences can be defined. For example, "AI assistant:".
    public var stop: String?
    
    /// Optional double for tail free sampling, reducing impact of less probable tokens.
    /// `tfsZ` adjusts how much the model avoids unlikely tokens, with higher values
    /// reducing their influence. A value of 1.0 disables this feature.
    public var tfsZ: Float?
    
    /// Optional integer for the maximum number of tokens to predict.
    /// `numPredict` sets the upper limit for the number of tokens to generate.
    /// A default of 128 tokens is typical, with special values like -1 for infinite generation.
    public var numPredict: Int?
    
    /// Optional integer to limit nonsense generation and control answer diversity.
    /// The `topK` parameter limits the set of possible tokens to the top-k likely choices.
    /// Lower values (e.g., 10) reduce diversity, while higher values (e.g., 100) increase it. Default is 40.
    public var topK: Int?
    
    /// Optional double working with top-k to balance text diversity and focus.
    /// `topP` (nucleus sampling) retains tokens that cumulatively account for a certain
    /// probability mass, adding flexibility beyond `topK`. A value like 0.9 increases diversity.
    public var topP: Float?
    
    /// Optional double for the minimum probability threshold for token inclusion.
    /// `minP` ensures that tokens below a certain probability threshold are excluded,
    /// focusing the model's output on more probable sequences. Default is 0.0, meaning no filtering.
    public var minP: Float?
    
    public init(mirostat: Int? = nil, mirostatEta: Float? = nil, mirostatTau: Float? = nil, numCtx: Int? = nil, repeatLastN: Int? = nil, repeatPenalty: Float? = nil, temperature: Float? = nil, seed: Int? = nil, stop: String? = nil, tfsZ: Float? = nil, numPredict: Int? = nil, topK: Int? = nil, topP: Float? = nil, minP: Float? = nil) {
        self.mirostat = mirostat
        self.mirostatEta = mirostatEta
        self.mirostatTau = mirostatTau
        self.numCtx = numCtx
        self.repeatLastN = repeatLastN
        self.repeatPenalty = repeatPenalty
        self.temperature = temperature
        self.seed = seed
        self.stop = stop
        self.tfsZ = tfsZ
        self.numPredict = numPredict
        self.topK = topK
        self.topP = topP
        self.minP = minP
    }
}
