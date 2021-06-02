clique Namespace
################


clique_getSnapshot
==================

+---------+-----------------------------------------------------------+
| Client  | Method invocation                                         |
+=========+===========================================================+
| Console | clique.getSnapshot(blockNumber)                           |
+---------+-----------------------------------------------------------+
| RPC     | {"method": "clique_getSnapsnot", "params": [blockNumber]} |
+---------+-----------------------------------------------------------+

实例::

    > clique.getSnapshot(5463755)
    {
      hash: "0x018194fc50ca62d973e2f85cffef1e6811278ffd2040a4460537f8dbec3d5efc",
      number: 5463755,
      recents: {
        5463752: "0x42eb768f2244c8811c63729a21a3569731535f06",
        5463753: "0x6635f83421bf059cd8111f180f0727128685bae4",
        5463754: "0x7ffc57839b00206d1ad20c69a1981b489f772031",
        5463755: "0xb279182d99e65703f0076e4812653aab85fca0f0"
      },
      signers: {
        0x42eb768f2244c8811c63729a21a3569731535f06: {},
        0x6635f83421bf059cd8111f180f0727128685bae4: {},
        0x7ffc57839b00206d1ad20c69a1981b489f772031: {},
        0xb279182d99e65703f0076e4812653aab85fca0f0: {},
        0xd6ae8250b8348c94847280928c79fb3b63ca453e: {},
        0xda35dee8eddeaa556e4c26268463e26fb91ff74f: {},
        0xfc18cbc391de84dbd87db83b20935d3e89f5dd91: {}
      },
      tally: {},
      votes: []
    }

