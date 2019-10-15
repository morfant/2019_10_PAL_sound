~masterEQ = ChannelEQ.new(2, s, 0, 0);


(
var rec = 0,
bassFreq = 76, bassFreqMax = 80,
hatFreq = 1000,
timeMul = 1, ampMul = 180,
onebeat = 2.666666666666/4, // 4 * beat = 1 bar
syn = 0;


if (rec == 1, {
s.prepareForRecord; // you have to call this first
s.record;

SystemClock.sched(
		onebeat*(4*16*2)*timeMul, {|time|
		time.postln;
		"Recording stop.".postln;
		s.stopRecording;
	}
);
});


// ~masterEQ.gui.onSelect('b&m');

~pbPlay_111 = ~pb111 = Pbind(
	\instrument,        \tak,
	\dur,    Pseq([
		onebeat, onebeat, onebeat, onebeat/2, onebeat, onebeat,
		onebeat, onebeat, onebeat, onebeat/2, onebeat, onebeat/2, onebeat/4, onebeat
	]*timeMul*3*0.7, inf),
	\legato, 0.5,
    \freq, Pseq([
        #[180, 240, 300], #[180, 240, 300], #[180, 240, 300], #[180, 200, 240], #[160, 200, 240], #[180, 200, 240],
        #[180, 240, 300], #[180, 240, 300], #[180, 240, 300], #[180, 200, 240], #[160, 200, 240], #[180, 200, 240],
        #[160, 200, 260]
    ]*0.7*0.45, inf), //original = 0.7
	// \freq, Pseq([100, 100, 100, 100]/4, inf),
	\atTime, Pseq([
        0.3, 0.3, 0.3.rand, 0.4, 0.3, 0.1.rand, 0.3,
        0.4, 0.3, 0.3, 0.01, 0.4, 0.6, 0.3,
		0.01
    ], inf),
	\susTime, Pseq([
        2, 2, 2, 2, 2, 2,
        2, 2, 2, 2, 2, 2,
		1
    ]/3.rand, inf),
	\amp, ampMul
).play;



~pbPlay_112 = ~pb112 = Pbind(
	\instrument,        \tak,
	\dur,    Pseq([
		onebeat, onebeat, onebeat, onebeat/2, onebeat, onebeat,
		onebeat, onebeat, onebeat, onebeat/2, onebeat, onebeat
	]*timeMul*3*0.7, inf),
	\legato, 0.5,
    \freq, Pseq([
        543, 544, 545, 544, 648, 543,
        542, 543, 549, 544, 728, 543,
        543, 544, 545, 544, 648, 543,
        542, 543, 549, 544, 868, 543
    ]*0.38*0.455/2, inf), //original 0.38
	// \freq, Pseq([100, 100, 100, 100]/4, inf),
	\atTime, Pseq([
        0.3, 0.3, 0.3, 0.4, 0.3, 0.3,
        0.4, 0.3, 0.3, 0.4, 0.6, 0.3, 0.01
    ], inf),
	\susTime, Pseq([
        2, 2, 2, 2, 2, 2,
        2, 2, 2, 2, 2, 2, 0.3
    ]/2, inf),
	\amp, ampMul * 0.6
).play;



// ~pbPlay_9 = ~pb3_30.play;




if (rec == 1, {
CmdPeriod.doOnce{ s.stopRecording;};
});

)


~pbPlay_111.stop;~pbPlay_112.stop;