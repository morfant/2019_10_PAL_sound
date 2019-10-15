/************************** Synth ***************************/

(
SynthDef.new(\zwei_ein,
	{
		arg freq = 300, amp = 0.2, gate = 1, atkTime = 2.0, relTime = 2.0;
		var sig, env;
		sig = SinOsc.ar(freq);
		env = EnvGen.kr(Env.asr(atkTime, releaseTime: relTime), gate: gate, doneAction: Done.freeSelf);

		Out.ar(0, Pan2.ar(sig * env, 0, amp));
	}
).add;


SynthDef(\liedRSaw,
    {
        |freq = 2598, amp = 0.3, gate = 1, efxfreq = 700, panfreq = 1, dronerq = 0.2, pfreq = 100, atkTime = 2.0, relTime = 2.0|
        var sig, sig2, sig3, env, efx, pansig, out, delay, drone;
		sig = Saw.ar(freq, mul: amp/2);
		sig2 = LFSaw.ar(freq/2, mul: amp/4);
		sig3 = LFPar.ar(freq*3/2, mul: amp/4);
        env = EnvGen.kr(Env.adsr(atkTime, 0.2, 0.8, releaseTime: relTime), gate, doneAction: 2);
		efx = RLPF.ar((sig+sig2+sig3)*env, efxfreq, 0.2, 1);
        drone = RLPF.ar(BrownNoise.ar(0.02), 120, dronerq, 1);
        delay = CombC.ar(efx+drone, 0.5, 0.1, 0.03, 1, efx);
        //env = EnvGen.kr(Env.asr(0.1, 0.2, 0.5), gate, doneAction: 2);
        pansig = LFTri.kr(panfreq, mul: 0.5, add: 0.25);
        out = Out.ar(0, Pan2.ar(delay, 0));
    }).add;
)

a = Synth(\liedRSaw)
a.set(\gate, 0)


/************************** Functions ***************************/
(
~isRunA = False;
~isRunB = False;
// Hidden Protocol main A
~main_A = {
	arg amp = 0.2, atkTime = 2.0;
	var a, b, c;

	if (~isRunA == False, {
		~isRunA = True;

		~synth_a_a = Synth(\liedRSaw, [\amp, amp, \atkTime, atkTime]);
		~synth_a_b = Synth(\liedRSaw, [\amp, amp, \atkTime, atkTime]);
		~synth_a_c = Synth(\liedRSaw, [\amp, amp, \atkTime, atkTime]);

		~loop_a = fork{
			inf.do{

				if (0.5.coin, {a = 59}, {a = 62});
				if (0.5.coin, {b = 65}, {b = 64});
				if (0.5.coin, {c = 67}, {c = 69});
				("value a: " + a).postln;
				("value b: " + b).postln;
				("value c: " + c).postln;

				// if (0.5.coin, {a2 = 5.rand}, {a2 = 5.rand * -1});
				// if (0.5.coin, {b2 = 7.rand}, {b2 = 7.rand * -1});
				// if (0.5.coin, {c2 = 9.rand}, {c2 = 9.rand * -1});
				// ("value a2: " + a2).postln;
				// ("value b2: " + b2).postln;
				// ("value c2: " + c2).postln;
				// (" ").postln;

				~synth_a_a.set(\freq, a.midicps);
				~synth_a_b.set(\freq, b.midicps);
				~synth_a_c.set(\freq, c.midicps);


				4.01.rand.wait;
			}
		}
	}, {
		("main_A is running already!".postln);

	});
};


// Hidden Protocol main B
~main_B = {
	arg amp = 0.2, atkTime = 2.0;
	var a, b, c;
	var a2, b2, c2;

	if (~isRunB == False, {
		~isRunB = True;

		~synth_b_a = Synth(\liedRSaw, [\amp, amp, \atkTime, atkTime]);
		~synth_b_b = Synth(\liedRSaw, [\amp, amp, \atkTime, atkTime]);
		~synth_b_c = Synth(\liedRSaw, [\amp, amp, \atkTime, atkTime]);

		~synth_b_aa = Synth(\zwei_ein, [\amp, amp/2, \atkTime, atkTime]);
		~synth_b_bb = Synth(\zwei_ein, [\amp, amp/2, \atkTime, atkTime]);
		~synth_b_cc = Synth(\zwei_ein, [\amp, amp/2, \atkTime, atkTime]);

		~loop_b = fork{
			inf.do{
				~isRunB = True;

				//        if (0.5.coin, {a = [64, 66].at(1.rand)}, {a = [65, 67].at(1.rand)});
				//        if (0.5.coin, {b = [70, 72].at(1.rand)}, {b = [71, 73].at(1.rand)});
				//        if (0.5.coin, {c = [76, 77].at(1.rand)}, {c = [79, 80].at(1.rand)});
				if (0.5.coin, {a = 60}, {a = 62});
				if (0.5.coin, {b = 65}, {b = 64});
				if (0.5.coin, {c = 67}, {c = 69});
				("value a: " + a).postln;
				("value b: " + b).postln;
				("value c: " + c).postln;

				if (0.5.coin, {a2 = 5.rand}, {a2 = 5.rand * -1});
				if (0.5.coin, {b2 = 7.rand}, {b2 = 7.rand * -1});
				if (0.5.coin, {c2 = 9.rand}, {c2 = 9.rand * -1});
				("value a2: " + a2).postln;
				("value b2: " + b2).postln;
				("value c2: " + c2).postln;
				(" ").postln;

				~synth_b_aa.set(\freq, (a).midicps);
				~synth_b_bb.set(\freq, (b).midicps);
				~synth_b_cc.set(\freq, c.midicps);

				~synth_b_a.set(\freq, abs(a2*10).midicps);
				~synth_b_b.set(\freq, abs(b2*7).midicps);
				~synth_b_c.set(\freq, abs(c2*8).midicps);


				4.01.rand.wait;
			}
		}
	}, {
		("main_B is running already!".postln);
	});
	};


	// fade out main A
	~main_A_end = {
		arg relTime = 2;
		~synth_a_a.set(\gate, -1 * (relTime + 1));
		~synth_a_b.set(\gate, -1 * (relTime + 1));
		~synth_a_c.set(\gate, -1 * (relTime + 1));
		~loop_a.stop;
		~isRunA = False;
	};


	// fade out main B
	~main_B_end = {
		arg relTime = 2;
		~synth_b_aa.set(\gate, -1 * (relTime + 1));
		~synth_b_bb.set(\gate, -1 * (relTime + 1));
		~synth_b_cc.set(\gate, -1 * (relTime + 1));
		~synth_b_a.set(\gate, -1 * (relTime + 1));
		~synth_b_b.set(\gate, -1 * (relTime + 1));
		~synth_b_c.set(\gate, -1 * (relTime + 1));
		~loop_b.stop;
		~isRunB = False;
	}
)


/************************** Sequence ***************************/

~main_A.value(0.2, 5.0) // (amp, atkTime)
~main_A_end.value(3) // (relTime)

~main_B.value()
~main_B_end.value();
