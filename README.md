robotlegs-bender-as3-modules
============================

WIP

When a new robotlegs context is created, the event dispatcher extension maps a shared event dispatcher into this context. 
Within the scope of a context, framework classes, like Mediators, Models, Services and Commands, can communicate with each other by dispatching events and/or listening for events on the shared event dispatcher. 

In an application with multiple contexts, each context will have its own shared event dispatcher. The dispatcher will be local to the scope defined by the context in which it has been mapped. 

Communication between multiple contexts is facilitated by the Module Connector. 
The relations between multiple contexts are hierarchical.
A parent context can have multiple child-contexts, and each child-context can also be a parent to other sub-contexts. Each child-context has only one parent-context.
By default, a child-context inherits dependencies from its parent-context and exposes dependencies to its children. See details: https://github.com/robotlegs/robotlegs-framework/tree/master/src/robotlegs/bender/extensions/modularity

Every context has a parent, with the exception of the "root" context (usually having the root display object as contextView).

Let's take the case of a "root" context (ShellContext) having 2 child-contexts (ModuleAContext and ModuleBContext) .
Each context has a local shared dispatcher, say, shellDispatcher, moduleADispatcher and moduleBDispatcher. Each context has the ModularityExtension installed, thus a ModuleConnector of its own. The ModuleConnector is building a bridge between contexts. That bridge is actually an IEventDispatcher mapped with root's injector: 
in the root context with its own injector, since it doesn't have a parent, and in the child-contexts with injector.parent. 

<code>
_rootInjector.map(IEventDispatcher, channelId).toValue(new EventDispatcher());
</code>

Now we have an inter-modular dispatcher, called channelDispatcher. The ModuleConnector has also a reference to the (local) shared event dispatcher of a context, localDispatcher.

In short, the ModularityExtension makes it possible for the channelDispatcher to listen for events dispatched on the local dispatcher, and for the local dispatcher to listen for events dispatched on the channelDispatcher, through an event relaying mechanism.
The EventRelay relays events from the source to the destination, where source and destination are 2 IEventDispatchers:

<code>		
_source.addEventListener(type, _destination.dispatchEvent);
</code>

(see robotlegs.bender.extensions.eventDispatcher.impl.EventRelay for details)

shellContext (dispatches)--------------------------------------moduleAContext(listens)

localDispatcher-------------> channelDispatcher-----------> localDispatcher

(shellDispatcher)-----------> channelDispatcher----------->( moduleADispatcher)

In order to enable the inter-modular communication we need to let ModuleConnector know which channelDispatcher to use between certain contexts and which event's types it has to listen to.

So, if we want the shellContext to dispatch an event to moduleAContext, on the default  channelDispatcher we map a connector like this:

Shell:

<code>
moduleConnector.onDefaultChannel()
                .relayEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);
</code>

ModuleA:

<code>
moduleConnector.onDefaultChannel()
	.receiveEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);
</code>

In one of the shell's classes we dispatch ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE on the shellDispatcher:

<code>
dispatch(new ModularConnectorEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE));
</code>

Inside ModuleA:

<code>
addContextListener(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE, onMessageReceived, ModularConnectorEvent);
</code>

The mappings for other channels, different from the default one would look like this:

Shell:

<code>
moduleConnector.onChannel('secretChannel')                .relayEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);
</code>

ModuleA:

<code>
moduleConnector.onChannel('secretChannel')
.receiveEvent(ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);
</code>

The ModularityExtension is calling EventRelay with the localDispatcher as the source dispatcher, when relayEvent is the ModuleConnectionAction defined through a mapping. 
If the  ModuleConnectionAction is receiveEvent, the channelDispatcher is the source dispatcher.

<code>
_localToChannelRelay = new EventRelay(localDispatcher, channelDispatcher).start();

_channelToLocalRelay = new EventRelay(channelDispatcher, localDispatcher).start();
</code>


Let's see the mappings for the 3 contexts I was talking about earlier, ShellContext, ModuleAContext and ModuleBContext. 
We define channels for events dispatched from shell to the modules, for events dispatched from modules to shell, and for the 2 modules communicating with each other.

Shell

<pre>
<code>
moduleConnector.onChannel('parent-child-channel')
. relayEvent (ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);
moduleConnector.onChannel('parent-child-channel')
. receiveEvent (ModularConnectorEvent.MODULES_TO_SHELL_MESSAGE);
</code>
</pre>

ModuleA

<pre>
<code>
moduleConnector.onChannel('parent-child-channel')
. receiveEvent (ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);

moduleConnector.onChannel('parent-child-channel')
. relayEvent (ModularConnectorEvent. MODULES_TO_SHELL_MESSAGE);

moduleConnector.onChannel('sibling -channel')
. relayEvent (ModularConnectorEvent.A_TO_B_MESSAGE);

moduleConnector.onChannel('sibling -channel')
. receiveEvent (ModularConnectorEvent.B_TO_A_MESSAGE);
</code>
</pre>

ModuleB

<pre>
<code>
moduleConnector.onChannel('parent-child-channel')
. receiveEvent (ModularConnectorEvent.SHELL_TO_MODULES_MESSAGE);

moduleConnector.onChannel('parent-child-channel')
. relayEvent (ModularConnectorEvent.MODULES_TO_SHELL_MESSAGE);

moduleConnector.onChannel('sibling -channel')
. receiveEvent (ModularConnectorEvent.A_TO_B_MESSAGE);

moduleConnector.onChannel('sibling -channel')
. relayEvent (ModularConnectorEvent.B_TO_A_MESSAGE);
</code>
</pre>

In this scenarios we have 2 channelDispatchers ('parent-child-channel' and 'sibling -channel'), and 3 localDispatchers. A custom event, ModularConnectorEvent, with 4 types : SHELL_TO_MODULES_MESSAGE, MODULES_TO_SHELL_MESSAGE, A_TO_B_MESSAGE, and B_TO_A_MESSAGE.

Easy, isn't it? :)

..more tp come soon..
