(
//Synth 1
SynthDef(\bass, {| out = 0, amp = 0.2, lf = 100, rq = 0.9, envdur = 0.4, gate = 1,
	freqs = #[220, 440, 880, 1760],
    amps=#[0.1, 0.23, 0.12, 0.05],
    phases=#[1, 1.5, 2, 2.5]|
	var env, sig, lowcut_sig;
	// env = EnvGen.kr(Env.sine(envdur), gate, doneAction: 2);
	env = EnvGen.kr(Env.new([0, 1, 0], [0.1, 0.1], [2, -5]), gate, doneAction: 2);
	sig = DynKlang.ar(`[freqs, amps, phases]);
	sig = RLPF.ar(sig, lf, rq);
	lowcut_sig = HPF.ar(sig, 100);
	// Out.ar(0, Pan2.ar(sig * env, 0, amp));
	Out.ar(out, Pan2.ar(lowcut_sig * env, 0, amp));
}).add;

Synth('bass', [\freqs, (#[200, 300] + (#[130, 140].rand)).postln, \amp, 3, \envdur, 0.2]);

// #[100, 200] + #[200, 200]
//Synth 2
SynthDef(\hat, {| out = 0, freq = 6000, amp = 0.6, amp2 = 0.9, filfreq = 1700, rq = 0.2, gate = 1, pan = 0 |
	var sig, env, sig2, lowcut_sig, lowcut_sig2;
	sig = LFPar.ar(freq);
	sig = RHPF.ar(sig, filfreq, rq, sig*0.1);
	sig2 = Impulse.ar(0, mul: amp2);
	lowcut_sig = HPF.ar(sig, 100);
	lowcut_sig2 = HPF.ar(sig2, 100);
	env = EnvGen.kr(Env.perc(0.05, 0.2), gate, doneAction: 2);
	// Out.ar(0, Pan2.ar(sig2 + sig * env, pan, amp));
	Out.ar(out, Pan2.ar(lowcut_sig2 + lowcut_sig * env, pan, amp));
}).add;

// Synth('hat', [\freq, 1000, \filfreq, 1000]);

//Synth 2
SynthDef(\hat2, {| out = 0, freq = 6000, amp = 0.6, amp2 = 0.9, filfreq = 1700, rq = 0.2, gate = 1, pan = 0, susTime = 1 |
	var sig, env, sig2, lowcut_sig, lowcut_sig2;
	sig = LFPar.ar(freq);
	sig = RHPF.ar(sig, filfreq, rq, sig*0.1);
	sig2 = Impulse.ar(0, mul: amp2);
	lowcut_sig = HPF.ar(sig, 100);
	lowcut_sig2 = HPF.ar(sig2, 100);
    env = EnvGen.kr(Env.linen(0.01, susTime), gate, doneAction: 2);
	// Out.ar(0, Pan2.ar(sig2 + sig * env, pan, amp));
	Out.ar(out, Pan2.ar(lowcut_sig2 + lowcut_sig * env, pan, amp));
}).add;

// Synth('hat2');

//Synth 3
SynthDef(\tak, {| out = 0, freq = 300, modfreq = 5, amp = 0.6, amp2 = 0.9, filfreq = 3200, rq = 0.1, gate = 1,
	atTime = 0.1, susTime = 2.0, relTime = 0.1, pan = 0 |

	var sig, env, sig2, del, mod, lowcut_sig;
	mod = LFSaw.kr(1/10, add: 1);
	sig = LFCub.ar(freq, mod);
	sig2 = Impulse.ar(0, mul: amp2);
	sig = BPF.ar((sig+sig2), filfreq, rq, sig*0.3);
	sig = DelayN.ar(sig, 0.4, 0.1, add: sig*0.3);
	lowcut_sig = HPF.ar(sig, 100);
	env = EnvGen.kr(Env.linen(atTime, susTime.rand, relTime), gate, doneAction: 2);
	// Out.ar(0, Pan2.ar((sig) * env, pan, amp));
	Out.ar(out, Pan2.ar((lowcut_sig) * env, pan, amp));
}).add;

// Synth('tak');

SynthDef(\tak2, {| out = 0, freq = 300, modfreq = 5, amp = 0.6, amp2 = 0.9, filfreq = 3200, rq = 0.1, gate = 1,
	atTime = 0.1, susTime = 2.0, relTime = 0.1, pan = 0 |

	var sig, env, sig2, del, mod, lowcut_sig;
	mod = LFSaw.kr(1/10, add: 1);
    sig = LFCub.ar(MouseY.kr(280, 820).poll*0.38, mod);
	sig2 = Impulse.ar(0, mul: amp2);
	sig = BPF.ar((sig+sig2), filfreq, rq, sig*0.3);
	sig = DelayN.ar(sig, 0.4, 0.1, add: sig*0.3);
	lowcut_sig = HPF.ar(sig, 100);
    env = EnvGen.kr(Env.linen(atTime, susTime, relTime, curve: 6), gate, doneAction: 2);
	// Out.ar(0, Pan2.ar((sig) * env, pan, amp));
	Out.ar(out, Pan2.ar((lowcut_sig) * env, pan, amp));
}).add;

// Synth('tak2');

//Synth 4
SynthDef(\dd, {| out = 0, freq = 1, modfreq = 5, amp = 0.6, amp2 = 0.9, filfreq = 300, rq = 0.1, gate = 1,
	atTime = 0.1, susTime = 0.1, relTime = 0.9, pan = 0 |
	var sig, env, sig2, del, mod, lowcut_sig, lowcut_sig2;
	sig = Blip.ar(freq);
	sig = LPF.ar(sig, filfreq);

	sig2 = Impulse.ar(0, mul: amp2);
	env = EnvGen.kr(Env.linen(atTime, susTime, relTime), gate, doneAction: 2);
	//env = EnvGen.kr(Env.perc(atTime, relTime), gate, doneAction: 2);
	lowcut_sig = HPF.ar(sig, 100);
	lowcut_sig2 = HPF.ar(sig2, 100);

    // Out.ar(0, Pan2.ar((sig + sig2) * env, pan, amp));
    Out.ar(out, Pan2.ar((lowcut_sig + lowcut_sig2) * env, pan, amp));
}).add;

// Synth('dd', ['amp', 20.0]);

//Synth 5
SynthDef(\dds, {| out = 0, freq = 1, modfreq = 5, amp = 0.6, amp2 = 0.9, filfreq = 300, rq = 0.1, gate = 1,
	atTime = 0.1, susTime = 0.1, relTime = 0.9, pan = 0, nf = 7|
	var sig, env, sig2, del, mod, lowcut_sig, lowcut_sig2;
	sig = Blip.ar(freq);
	sig = LPF.ar(sig, filfreq);

	// sig2 = Impulse.ar(0, mul: amp2);
    // sig2 = LFNoise0.ar(nf);
    sig2 = LFNoise0.kr(nf);
	env = EnvGen.kr(Env.linen(atTime, susTime, relTime), gate, doneAction: 2);
	//env = EnvGen.kr(Env.perc(atTime, relTime), gate, doneAction: 2);
	lowcut_sig = HPF.ar(sig, 100);
    lowcut_sig2 = LPF.ar(HPF.ar(sig2, 100), 500, 0.7);

    Out.ar(out, Pan2.ar(HPF.ar((sig + sig2), 100) * env, pan, amp));
    // Out.ar(0, Pan2.ar((lowcut_sig + lowcut_sig2) * env, pan, amp));
}).add;

// Synth('dds');

//stool
SynthDef(\ten, {| freq = 500, modfreq = 5, amp = 0.4, amp2 = 0.9, filfreq = 300, rq = 0.1, gate = 1, nff = 2.5,
	atTime = 0.1, susTime = 0.1, relTime = 0.9, pan = 0, nf = 7, hpc1 = 100, hpc2 = 100, cv = 9|
	var sig, env, sig2, del, mod, lowcut_sig, lowcut_sig2, gateSig;
	// sig = LFSaw.ar(freq);
	sig = LFNoise0.ar(freq);
	sig = LPF.ar(sig, filfreq);

	// sig2 = Impulse.ar(0, mul: amp2);
	sig2 = LFNoise0.kr(nf);
	// env = EnvGen.kr(Env.linen(atTime, susTime, relTime), gate, doneAction: 2);
	// gateSig = LFNoise0.kr(nff);
	gateSig = 1;
	// env = EnvGen.kr(Env.linen(sustainTime: LFNoise0.kr(2).range(0.01, 0.5), releaseTime: 0.05, curve: 9), gateSig, doneAction: 2);
	env = EnvGen.kr(Env.linen(sustainTime: susTime, releaseTime: relTime, curve: cv), gateSig, doneAction: 2);
	//env = EnvGen.kr(Env.perc(atTime, relTime), gate, doneAction: 2);
	lowcut_sig = HPF.ar(sig, hpc1);
	lowcut_sig2 = HPF.ar(sig2, hpc2);

	Out.ar(0, Pan2.ar((sig + sig2) * env, pan, amp));
	// Out.ar(0, Pan2.ar((sig + lowcut_sig2) * env, pan, amp));
}).add;

// Synth('ten', ['amp', 0.5, 'amp2', 0.4, 'freq', rrand(766, 500), 'nf', rrand(500, 100), 'susTime', 0.05, 'relTime', 0.1, 'hpc1', 300, 'hpc2', 100, 'cv', -10]);

//Synth - mic in
SynthDef(\micin, {| amp = 0, gate = 1 |
    var sig;
    sig = SoundIn.ar(0);
    Out.ar(0, Pan2.ar(sig, 0, amp));
}).add;




SynthDef(\gobeat, {|freq = 240, dur = 0.2, gate = 1, amp = 0.5|
	// var env = Line.kr(0.2, 0.0, dur, doneAction:2);
	var env = EnvGen.kr(Env.perc(0.01, dur), gate, doneAction: 2);
	var sig = SinOsc.ar(freq, 0, env);
	Out.ar(0, Pan2.ar(sig)*amp);
}).add;

// Synth('gobeat')

// conceptual dance
SynthDef(\condan, {|freq = 240, dur = 0.2, gate = 1, amp = 0.5, freq2 = 33, amp2 = 0.5|
	var env = EnvGen.kr(Env.perc(0.01, dur), gate, doneAction: 2);
	var sig2 = LFSaw.kr(freq2, mul: amp2);
	// var sig2 = LFPar.kr(freq2, mul: amp2);
	var sig = SinOsc.ar(freq, mul: env*sig2);

	Out.ar(0, Pan2.ar(sig)*amp);
}).add;


// Synth('condan', ['freq', rrand(100, 400), 'amp', 2.0])

SynthDef(\sine, {|freq = 240, dur = 0.2, gate = 1, atk = 0.1, amp = 0.5|
	// var env = EnvGen.kr(Env.perc(atk, dur), gate, doneAction: 2);
	var env = Line.kr(0.2, 0.0, dur, doneAction:2);
	var sig = SinOsc.ar(freq, 0, env);
	var sig2 = SinOsc.kr(freq/4, mul: env);
	var no = WhiteNoise.ar(env) * 0.005 * LFTri.kr(80, mul: 0.4);
	Out.ar(0, Pan2.ar(sig*sig2+no)*amp);
}).add;

SynthDef(\ddd, {|freq = 240, dur = 0.2, gate = 1, atk = 0.1, amp = 0.5, toneLow = 7, toneGain = 0.3|
	var env = EnvGen.kr(Env.perc(atk, dur), gate, doneAction: 2);
	var sig2 = SinOsc.kr(freq/toneLow, mul: toneGain);
	var sig = SinOsc.ar(freq*sig2, pi/6);
	var no = WhiteNoise.ar(0.005) * LFTri.kr(80, mul: 0.4);
	Out.ar(0, Pan2.ar((sig+no)*env)*amp);
}).add;

//new lead - freq를 set 으로 변화 할 때 특별한 효과가 생긴다.
SynthDef(\liedR,
    {
        |freq = 2598, amp = 0.3, gate = 1, efxfreq = 700, panfreq = 3, dronerq = 0.4|
        var sig, env, efx, pansig, out, delay, drone;
        sig = Saw.ar(freq, mul: amp);
        env = EnvGen.kr(Env.adsr(0.1, 0.2, 0.5, 2, 1), gate, doneAction: 2);
        efx = RLPF.ar(sig*env, efxfreq, 0.2, 1);
        drone = RLPF.ar(BrownNoise.ar(0.01), 120, dronerq, 1);
        delay = CombC.ar(efx+drone, 0.2, 0.1, 0.03, 1, efx);
        //env = EnvGen.kr(Env.asr(0.1, 0.2, 0.5), gate, doneAction: 2);
        pansig = LFTri.kr(panfreq, mul: 0.5, add: 0);
        out = Out.ar(0, Pan2.ar(delay, pansig));
    }).add;

SynthDef("latooncarfian", { arg out = 0, freq = 440, chFreq1 = 2, chFreq2 = 2,
	a = 1, b = 3, c = 0.5, d = 0.5, gate = 1, amp = 0.3;
    var s1, s2, env;
        s1 = LatoocarfianN.ar(
    SampleRate.ir/4,
    LFNoise2.kr(chFreq1,1.5,1.5),
    LFNoise2.kr(chFreq1,1.5,1.5),
    LFNoise2.kr(chFreq1,0.5,1.5),
    LFNoise2.kr(chFreq1,0.5,1.5), mul: 0.1
);

        s2 = LatoocarfianN.ar(
    SampleRate.ir/4,
    LFNoise2.kr(chFreq2,1.5,1.5),
    LFNoise2.kr(chFreq2,1.5,1.5),
    LFNoise2.kr(chFreq2,0.5,1.5),
    LFNoise2.kr(chFreq2,0.5,1.5), mul: 0.1
);

Out.ar(out, [s1, s2] * amp);

}).add;


SynthDef(
    \hafen,
    {
        arg freqScale = 200, amp = 0.1, gate = 1, inNum = 0;
        var sig, env, envgen, inputs, n = 32;
        inputs = [PinkNoise.ar(0.3), WhiteNoise.ar(0.1), ClipNoise.ar(0.1), BrownNoise.ar(0.2)];
        sig = DynKlank.ar(`[ (1..13)*freqScale, 1/(1..13), nil ],
            Select.ar(inNum, inputs));
        env = Env(
		[0]++{0.8.rand.squared}.dup(n-1) ++ [0],
				{rrand(0.1,0.3)}.dup(n),
				\lin, n-8, 8 );
        envgen = EnvGen.kr(env, gate, doneAction: 2);
        Out.ar(0, Pan2.ar(sig * envgen, 0, amp));
    }
).add;


SynthDef("lfp", { arg out = 100, freq = 440, chFreq1 = 2, chFreq2 = 2,
	a = 1, b = 3, c = 0.5, d = 0.5,
	aa = 1, bb = 3, cc = 0.5, dd = 0.5,
	gate = 1, amp = 0.1;
    var s1, s2, env;
    env = EnvGen.kr(Env.perc(0.15, 0.05), gate, doneAction: 2);
    s1 = LatoocarfianN.ar(SampleRate.ir/4, a, b, c, d, mul: 0.1);
    s2 = LatoocarfianN.ar(SampleRate.ir/4, aa, bb, cc, dd, mul: 0.1);

Out.ar(out, [s1, s2]*env*amp);

}).add;


// Synthdef 4 - Reverb
SynthDef(\verb,
    {
        arg in = 0, room = 2, rtime = 1, dam = 0.3, sp = 5, tail = 0.2;
        var sig, fil;
        sig = In.ar(in, 1);
        fil = GVerb.ar(sig, room = 2, rtime, dam, 0.5, sp, taillevel: tail);
        Out.ar(0, fil);

}).add;


// Synthdef 5
SynthDef(\woong,
    {
        arg cutoff = 202, rq = 1.0, sn = 8, amp = 0.5, gate = 1, freq = 55, freq2 = 75, freq3 = 100;
        var sig, fil, lfo, env;

		env = EnvGen.kr(Env.perc, gate, doneAction: 2);
        lfo = LFClipNoise.kr(sn, mul: 0.5, add: 0.5);
		sig = Mix.new([Saw.ar(freq, mul: amp/2), Saw.ar(freq3, mul: amp/2), Saw.ar(freq2, mul: amp/2)]) * lfo;
        fil = RLPF.ar(sig, cutoff, rq);
		Out.ar(0, Pan2.ar(fil*amp*env, 0));
    }
).add;


// {Mix.new([Saw.ar(100, mul: 0.4), Saw.ar(200, mul: 0.4)])!2}.play;

// Synthdef 6
SynthDef(\woonglong,
    {
        arg cutoff = 202, rq = 1.0, sn = 8, gate = 1, amp = 0.6;
        var sig, fil, lfo, env;

        env = EnvGen.kr(Env.asr(1.3, 1, 3), gate, doneAction: 2);
        sig = Saw.ar(#[50, 75], 1);
        fil = RLPF.ar(sig, cutoff, rq);
        Out.ar(0, fil * env * amp);
    }
).add;


// Synthdef 7
SynthDef(\dirac, {| out, amp = 0.03, freq = 100, decay = 0.01, pos = -1 |
		var i = Impulse.ar(0), sig;
//		sig = Mix.fill(6, {Ringz.ar(i, Rand(freq, freq*[1.5, 2]), decay)});
		sig = Mix.fill(6, {Ringz.ar(i, Rand(freq, freq*1.5), decay)});
		DetectSilence.ar(sig, doneAction: 2);
		sig = Pan2.ar(sig, pos, amp);
		Out.ar(out, sig);
	}).add;


SynthDef(\chal, {| out, amp = 0.03, freq = 100, decay = 0.01, pos = 0, freqBase = 120, ampBase = 0.3, gate = 1 |
		var i = Impulse.ar(10), sig, sigCol, fil;
	// sigCol = LFSaw.ar(freqBase, mul: ampBase);
		sigCol = SinOsc.ar(freqBase, mul: ampBase);
//		sig = Mix.fill(6, {Ringz.ar(i, Rand(freq, freq*[1.5, 2]), decay)});
	sig = Mix.fill(6, {Blip.ar(Rand(freq, freq*1.5), 1) * EnvGen.kr(Env.perc(0.01, 0.2), gate, doneAction: 2)});
	fil = LPF.ar(sig, 300);
		DetectSilence.ar(sig, doneAction: 2);
		sig = Pan2.ar(fil*sigCol, pos, amp);
		Out.ar(out, sig);
	}).add;




// Synthdef 8
SynthDef("help-TCoin_ori", { arg out=0, prob=0.5, freq = 20, freq_am = 0.5, amp = 0.2;
	var trig;
	trig = Impulse.ar(freq, 0, SinOsc.kr(freq_am,0,1,1));
	// trig = Impulse.ar(SinOsc.kr(0.01, 0, freq+100, freq+300), 0, SinOsc.kr(freq_am,0,1,1));
	Out.ar(out,
		// Mix.fill(3, {Ringz.ar(CoinGate.ar(prob, trig*0.5), #[1,1.5, 2, 4]*Rand(50, 90), 0.01)})*amp
		SinOsc.ar(#[1, 1.5, 3]*freq)*amp

	)
}).add;

SynthDef("help-TCoin", { arg out=0, prob=0.5, freq = 20, freq_am = 0.5, amp = 0.2, gate = 1;
	var trig, env;
	env = EnvGen.kr(Env.perc, gate, doneAction: 2);
	trig = Impulse.ar(freq, 0, SinOsc.kr(freq_am,0,1,1));
	// trig = Impulse.ar(SinOsc.kr(0.01, 0, freq+100, freq+300), 0, SinOsc.kr(freq_am,0,1,1));
	Out.ar(out,
		// Mix.fill(3, {Ringz.ar(CoinGate.ar(prob, trig*0.5), #[1,1.5, 2, 4]*Rand(50, 90), 0.01)})*amp
		SinOsc.ar(#[1, 1.5, 3]*freq)*amp*env
	)
}).add;

SynthDef("help-TCoin_house", { arg out=0, prob=0.5, freq = 20, freq_am = 0.5, amp = 0.2, gate = 1,
	atkTime = 0.3, relTime = 0.1;
	var trig, env;
	// env = EnvGen.kr(Env.perc(0.3, 1), gate, doneAction: 2);
	env = EnvGen.kr(Env.perc(), gate, doneAction: 2);
	trig = Impulse.ar(freq, 0, SinOsc.kr(freq_am,0,1,1));
	// trig = Impulse.ar(SinOsc.kr(0.01, 0, freq+100, freq+300), 0, SinOsc.kr(freq_am,0,1,1));
	Out.ar(out,
		// Mix.fill(3, {Ringz.ar(CoinGate.ar(prob, trig*0.5), #[1,1.5, 2, 4]*Rand(50, 90), 0.01)})*amp
		SinOsc.ar(#[1, 1.5, 3]*freq)*amp*env
	)
}).add;


SynthDef(\sori,
	{
		arg amp = 1, freq = 20, freq2 = 20, gate = 1, ph = 0,
		freq3 = 10, filfreq = 100, rq = 0.2, freq4 = 100, dop = 0.5, harm = 200 ;
		var sig, env, sig2, env2, sig3, sig4, fil;
		//		env2 = EnvGen.kr(Env.perc(0.1, 0.5), gate, doneAction: 2);
		env2 = EnvGen.kr(Env.asr, gate, doneAction: 2);
		//		sig2 = SinOsc.kr(freq2*env2, ph);
		//		sig2 = LFTri.kr(freq2*env2, ph);
		//		sig2 = WhiteNoise.kr(1);
		sig4 = Blip.kr(freq4, harm);
		sig3 = SinOsc.kr(freq3);
		sig2 = LFNoise0.kr(freq2);

		sig = SinOsc.ar(freq*sig4, mul: 1);
		env = EnvGen.kr(Env.asr, gate, doneAction: 2);
		fil = RHPF.ar(sig, freq, rq);
		Out.ar(0, Pan2.ar(fil*env*amp));
	}
).add;


//Synth - mic in
SynthDef(\micin, {| in = 0, amp = 0, gate = 1 |
    var sig;
    sig = SoundIn.ar(in);
    Out.ar(0, Pan2.ar(sig, 0, amp));
}).add;
)