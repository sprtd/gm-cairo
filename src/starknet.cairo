%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func names(address) -> (name: felt) {
}


@event
func stored_name(address: felt, name: felt) {
}

@constructor 
func constructor{syscall_ptr: felt*, perdesen_ptr: HashBuiltin*, range_check_ptr} (_name: felt) {
    let (caller) = get_caller_address();

    names.write(caller, _name);
    return ();
} 


@external
func store_name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _name: felt
) {
    // get caller from get_caller_address imported library
    let (caller) = get_caller_address();    

    // save _caller and _name in names state var
    names.write(caller, _name);

    // emit `stored_name` event
    stored_name.emit(caller, _name);

}


@view 
func get_name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr} (_address: felt) {
    // fetch name by passing _address parameter to names state var
    let (name) = names.read(_address);

    // return fetched name
    return (name);
}