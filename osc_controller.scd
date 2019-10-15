a = Synth(\hat, [\freq, 700])

b = Synth(\tak, [\freq, 200])

c = Synth(\dd, [\freq, 1200])



a = Synth(\tak, [\freq, 41.midicps, \filfreq, 1300, \amp, 15])
a = Synth(\tak, [\freq, 45.midicps, \filfreq, 3300, \amp, 15])
a = Synth(\tak, [\freq, 41.midicps, \filfreq, 1300, \amp, 15])
a = Synth(\tak, [\freq, 40.midicps, \filfreq, 1300, \amp, 15])
a = Synth(\tak, [\freq, 36.midicps, \filfreq, 2300, \amp, 15])

OSC

n = NetAddr("127.0.0.1", NetAddr.langPort);	//Check IP addr of ipad/iphone. - giy air

(
o.free;
o = OSCFunc({|msg, time, addr, recvPort|
	msg.postln;

}, '/fromUnity', n);
)

o;
n.sendMsg("/fromUnity", "hihihi")


(
p.free;
p = OSCFunc({|msg, time, addr, recvPort|
	msg.postln;
	l.sendMsg('/fromUnity', msg);

}, '/fromUnity', l);
)

NetAddr.langPort;
NetAddr.localAddr;

thisProcess.openUDPPort(3000);
thisProcess.openPorts;

n = NetAddr.new("127.0.0.1", 3000);

(
o.free;
o = OSCFunc({|msg, time, addr, recvPort|
	msg.postln;
	// Synth(\hat, [\freq, 300 + 100.rand, \amp, 1]);
	Synth(\tak, [\freq, 700.rand]);
	// Synth(\dd, [\freq, 700.rand]);
}, 'fromUnity');
)


OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off


s.serverOp
ServerOptoins
s.options.memSize


a = Synth(\hat)

(
SynthDef(\test, {
	arg freq = 199, gate = 1;
	var sig, env;
	env = EnvGen.kr(Env.perc(), gate: gate, doneAction: Done.freeSelf);
	sig = LFSaw.ar(freq, mul: env/50);
	Out.ar(0, Pan2.ar(sig, 0));
}).add;
)


o.free;
o = OSCFunc({|msg, time, addr, recvPort|
	msg.postln;
	// Synth(\hat, [\freq, 300 + 100.rand, \amp, 1]);
	// Synth(\tak, [\freq, 700.rand]);
	// Synth(\dd, [\freq, 700.rand]);
}, 'look', n);

a = Synth(\test);
n = NetAddr("127.0.0.1", NetAddr.langPort);	//Check IP addr of ipad/iphone. - giy air

Synth(\tak, [\freq, 100, \amp, 200, \susTime, 0.1]);
Synth(\tak, [\freq, 700, \amp, 70, \susTime, 0.1]);
Synth(\tak, [\freq, 400, \amp, 90, \susTime, 0.1]);
Synth(\tak, [\freq, 500, \amp, 100, \susTime, 0.1]);


/****************************************** ********************************************/




OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off


thisProcess.openUDPPort(3000);
thisProcess.openPorts;


( // OSC receiver
var counter_trace = 0;

~o_trace.free;
~o_trace = OSCFunc({|msg, time, addr, recvPort|
	msg.postln;
	// Synth(\hat, [\freq, 300 + 100.rand, \amp, 1]);
	// Synth(\tak, [\freq, [700, 500, 400].choose]);

	counter_trace = counter_trace + 1;
	// counter_trace.postln;

	if (counter_trace % 10 == 0, {
		Synth(\tak, [\freq, rrand(80, 120)]);
	});


	// Synth(\dd, [\freq, 700.rand]);
}, '\trace');

~o_look.free;
~o_look = OSCFunc({|msg, time, addr, recvPort|
	var look_o, look_x;
	msg.postln;

	look_o = msg[1];
	look_x = msg[2];

	// Synth(\hat, [\freq, 300 + 100.rand, \amp, 1]);
	// Synth(\tak, [\freq, 700.rand]);
	// Synth(\dd, [\freq, 700.rand]);
}, '\look');


~o_switch.free;
~o_switch = OSCFunc({|msg, time, addr, recvPort|
	msg.postln;
	if (msg[1] == 1, {
		// Depend on 'main_theme.scd'
		// world A
		~main_B_end.value();
		~main_A.value(0.2, 5.0); // (amp, atkTime)
	}, {
		// world B
		~main_A_end.value(3); // (relTime)
		~main_B.value();
	})

}, '\switch');
)








