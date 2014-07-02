package com.plumbee.stardust.controller
{
import com.plumbee.stardust.model.ProjectModel;

import flash.events.IEventDispatcher;

public class StoreParticleStateCommand
{

    [Inject]
    public var projectSettings : ProjectModel;

    [Inject]
    public var dispatcher : IEventDispatcher;

    public function execute() : void
    {

    }
    /*
    // sketch how to store particle data
    private function takeSnapshot() : void
    {
        const particleData : Object = {};
        for each (var em : EmitterValueObject in projectSettings.stadustSim.emitters)
        {
            const allParticles : Array = [];
            const iterator : ParticleIterator = em.emitter.particles.getIterator();
            const pData = new ParticleData( iterator.particle() );
            allParticles.push(pData);
            particleData[em.id] = allParticles;
        }
        registerClassAlias("com.plumbe.asdf.ParticleData", ParticleData);
        // serialize particle data
        var barr : ByteArray = new ByteArray();
        barr.writeObject(allParticles);
        // store the byteArray in a model until user hits save
        zip.addFile(barr)
    }

    // sketch how to restore from a ByteArray.
    // Something similar as the SnapshotRestore class:
    // This code could go to the preUpdate() function - and could be invoked at a time set by a parameter:
    // it removes all existing particles from the emitter when invoked and adds the ones in the array.
    // the only downside is that it will need Base64 serialization which can be slow.
    // (and the stardust XML deserialization might be slow as a result too)
    private  function restoreSnapshot():void
    {
        var bArr : ByteArray = zip.getFile(); // or get it from a parameter
        var particlesData : Object = bArr.readObject();
        var factory = new PooledParticle2DFactory();
        for each (var em : EmitterValueObject in loader.project.emitters)
        {
            var arr : Array =  particlesData[em.id];
            var particles:ParticleCollection = factory.createParticles(arr.length, 0);
            var iter:ParticleIterator = particles.getIterator();

            var p:Particle;
            var particleNum : uint;
            while (p = iter.particle()) {
                setupParticle(p, arr[particleNum]);
            }
            em.emitter.addParticles( particles);
        }
    }

    private function setupParticle(particle, particleData) : void
    {
        // set particle properties from the array
    }
    */
}
}
