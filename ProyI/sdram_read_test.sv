/*
* |---------------------------------------------------------------|
* | Basic Test                                                    |
* |                                                               |
* |---------------------------------------------------------------|
*/

class sdram_read_test extends sdram_base_test;

   `uvm_component_utils(sdram_read_test)

    function new (string name="test", uvm_component parent=null);
        super.new (name, parent);
    endfunction

    task main_phase(uvm_phase phase);
       phase.raise_objection(.obj(this));
       #5000ns;
       do_reads();
       phase.drop_objection(.obj(this));
    endtask

    task do_reads();
        bit ok;
        for(int loops = 0; loops < 10; loops++) begin
            for (int reads = 0; reads < 10; reads++) begin
                seq = sdram_sequence::type_id::create(.name("seq"), .contxt(get_full_name()));
                ok = seq.randomize() with {
                    cmd == READ;
                };
                assert (ok) else `uvm_fatal("SDRAM_TEST", "Randomization failed");
                seq.start(env.agent.sequencer);
            end
        end
    endtask

endclass : sdram_read_test
