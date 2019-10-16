// 실행 방법
// 아래 괄호 안쪽에 커서를 둔 채로, cmd + enter


// 실행 중지
// cmd + .

(
s.boot;
s.waitForBoot({

"hiddenprotocol-synth.scd".loadRelative;
"hiddenprotocol-theme.scd".loadRelative;

~main_A_end.value();
~main_A.value(0.2, 5.0); // (amp, atkTime)

// ~o_trace.free;
// ~o_trace = OSCFunc({|msg, time, addr, recvPort|
// 	// msg.postln;
// 	// Synth(\hat, [\freq, 300 + 100.rand, \amp, 1]);
// 	// Synth(\tak, [\freq, [700, 500, 400].choose]);

// 	counter_trace = counter_trace + 1;
// 	// counter_trace.postln;

// 	if (counter_trace % 10 == 0, {
// 		Synth(\tak, [\freq, rrand(80, 120)]);
// 	});


// 	// Synth(\dd, [\freq, 700.rand]);
// }, '\trace');

// ~o_look.free;
// ~o_look = OSCFunc({|msg, time, addr, recvPort|
// 	var look_o, look_x;
// 	// msg.postln;

// 	look_o = msg[1];
// 	look_x = msg[2];

// 	// Synth(\hat, [\freq, 300 + 100.rand, \amp, 1]);
// 	// Synth(\tak, [\freq, 700.rand]);
// 	// Synth(\dd, [\freq, 700.rand]);
// }, '\look');

// ~o_eyeon.free;
// ~o_eyeon = OSCFunc({|msg, time, addr, recvPort|
// 	msg.postln;

// 	Synth('bass', [\freqs, (#[200, 300] + (#[130, 140].rand*5)).postln, \amp, 3, \envdur, 0.2]);
// 	// Synth(\hat, [\freq, 300 + 100.rand, \amp, 1]);
// 	// Synth(\tak, [\freq, 700.rand]);
// 	// Synth(\dd, [\freq, 700.rand]);
// }, '\eyeon');

~o_switch.free;
~o_switch = OSCFunc({|msg, time, addr, recvPort|
	// msg[1].postln;
	// Synth(\tak, [\freq, 36.midicps, \filfreq, 2300, \amp, 605]);
	// Synth(\dds, [\amp, 6.0]);

	// switching effect
	Synth('ten', ['amp', 0.2, 'amp2', 0.1, 'freq', rrand(1766, 500), 'nf', rrand(1500, 100), 'susTime', 0.05, 'relTime', 0.1, 'hpc1', 100, 'hpc2', 100, 'cv', -10]);
	Synth('bass', [\freqs, (#[200, 300] + (#[130, 140].rand*5)).postln, \amp, 20, \envdur, 0.2]);

	// Synth('condan', ['freq', rrand(3500, 6000), 'amp', 2.0]);
	// Synth('dd', ['freq', 1, 'modfreq', 100, 'filfreq', 1700, 'amp', 30.0]);


	if (msg[1] == '1', {

		// Depend on 'main_theme.scd'
		// world A
		// ~main_A_end.value();
		~main_B_end.value(0.1);
		~main_A.value(0.2, 0.1); // (amp, atkTime)
	});
	if (msg[1] == '0',{
		// "000".postln;
		~main_A_end.value(0.1); // (relTime)
		~main_B.value(0.2, 0.2);
	});

}, '\switch');
});
)








