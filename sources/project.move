module MyModule::AssetTracking {

    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a tokenized asset.
    struct Asset has store, key {
        asset_name: vector<u8>,  // Name of the asset
        owner: address,          // Current owner of the asset
    }

    /// Function to register a new asset.
    public fun register_asset(owner: &signer, asset_name: vector<u8>) {
        let asset = Asset {
            asset_name,
            owner: signer::address_of(owner),
        };
        move_to(owner, asset);
    }

    /// Function to transfer ownership of an asset.
    public fun transfer_asset(current_owner: &signer, new_owner: address) acquires Asset {
        let asset = borrow_global_mut<Asset>(signer::address_of(current_owner));

        // Transfer the ownership
        asset.owner = new_owner;
    }
}
