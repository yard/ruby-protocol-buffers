using System;

namespace Abot.Entities {
  public class Base {

    public Base(object arg) {}

    public Base() {}

    protected virtual void ApplyProperties( byte[] bytes ) {
    }

    protected Abot.Rpc.Task Invoke<T>(string name, object arg) {
      return null;
    }

    protected Abot.Rpc.Task<R> Invoke<R, T>(string name, object arg) {
      return null;
    }

    public static T FromMailbox<T>(Phoenix.Messages.Mailbox mb) {
      return default(T);
    }

    public Phoenix.Messages.Mailbox ToMailbox() {
      return null;
    }

    public static void Main(string[] args) {}
  }
}

namespace Abot.Async {

  public class Task {}

  public class Task<T> {}

}

namespace Phoenix.Messages {

  public interface IResponseMessage<T> {
    T Value { get; }
  }

  [global::System.Serializable, global::ProtoBuf.ProtoContract( Name = @"Mailbox" )]
  public partial class Mailbox : global::ProtoBuf.IExtensible {
    public Mailbox() {
    }

    private string _entity;

    [global::ProtoBuf.ProtoMember( 1, IsRequired = true, Name = @"entity", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public string Entity {
      get { return _entity; }
      set { _entity = value; }
    }

    private string _id;

    [global::ProtoBuf.ProtoMember( 2, IsRequired = true, Name = @"id", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public string Id {
      get { return _id; }
      set { _id = value; }
    }

    private byte[] _propertiesBytes;

    [global::ProtoBuf.ProtoMember( 3, IsRequired = true, Name = @"properties_bytes", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public byte[] PropertiesBytes {
      get { return _propertiesBytes; }
      set { _propertiesBytes = value; }
    }

    private global::ProtoBuf.IExtension extensionObject;

    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject( bool createIfMissing ) {
      return global::ProtoBuf.Extensible.GetExtensionObject( ref extensionObject, createIfMissing );
    }
  }

  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"Void")]
  public partial class Void : global::ProtoBuf.IExtensible
  {
    public Void() {}

    private global::ProtoBuf.IExtension extensionObject;
    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
    { return global::ProtoBuf.Extensible.GetExtensionObject(ref extensionObject, createIfMissing); }
  }

}

namespace Abot.Rpc {

  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"Call")]
  public partial class Call : global::ProtoBuf.IExtensible {
    public Call() {
    }

    private string _cookie;

    [global::ProtoBuf.ProtoMember( 1, IsRequired = true, Name = @"cookie", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public string Cookie {
      get { return _cookie; }
      set { _cookie = value; }
    }

    private string _entity;

    [global::ProtoBuf.ProtoMember( 2, IsRequired = true, Name = @"entity", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public string Entity {
      get { return _entity; }
      set { _entity = value; }
    }

    private string _id;

    [global::ProtoBuf.ProtoMember( 3, IsRequired = false, Name = @"id", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public string Id {
      get { return _id; }
      set { _id = value; }
    }

    private string _method;

    [global::ProtoBuf.ProtoMember( 4, IsRequired = true, Name = @"method", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public string Method {
      get { return _method; }
      set { _method = value; }
    }

    private byte[] _argsBytes;

    [global::ProtoBuf.ProtoMember( 5, IsRequired = true, Name = @"args_bytes", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public byte[] ArgsBytes {
      get { return _argsBytes; }
      set { _argsBytes = value; }
    }

    private global::ProtoBuf.IExtension extensionObject;

    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject( bool createIfMissing ) {
      return global::ProtoBuf.Extensible.GetExtensionObject( ref extensionObject, createIfMissing );
    }
  }

  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"Envelope")]
  public partial class Envelope : global::ProtoBuf.IExtensible {
    public Envelope() {
    }

    private Envelope.EnvelopeType _type;

    [global::ProtoBuf.ProtoMember( 1, IsRequired = true, Name = @"type", DataFormat = global::ProtoBuf.DataFormat.TwosComplement )]
    [global::System.ComponentModel.DefaultValue( Envelope.EnvelopeType.CALL )]
    public Envelope.EnvelopeType Type {
      get { return _type; }
      set { _type = value; }
    }

    private Call _call = null;

    [global::ProtoBuf.ProtoMember( 2, IsRequired = false, Name = @"call", DataFormat = global::ProtoBuf.DataFormat.Default )]
    [global::System.ComponentModel.DefaultValue( null )]
    public Call Call {
      get { return _call; }
      set { _call = value; }
    }

    private Result _result = null;

    [global::ProtoBuf.ProtoMember( 3, IsRequired = false, Name = @"result", DataFormat = global::ProtoBuf.DataFormat.Default )]
    [global::System.ComponentModel.DefaultValue( null )]
    public Result Result {
      get { return _result; }
      set { _result = value; }
    }

    [global::ProtoBuf.ProtoContract( Name = @"EnvelopeType" )]
    public enum EnvelopeType {

      [global::ProtoBuf.ProtoEnum( Name = @"CALL", Value = 0 )]
      CALL = 0,

      [global::ProtoBuf.ProtoEnum( Name = @"RESULT", Value = 1 )]
      RESULT = 1
    }

    private global::ProtoBuf.IExtension extensionObject;

    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject( bool createIfMissing ) {
      return global::ProtoBuf.Extensible.GetExtensionObject( ref extensionObject, createIfMissing );
    }
  }

  [global::System.Serializable, global::ProtoBuf.ProtoContract(Name=@"Result")]
  public partial class Result : global::ProtoBuf.IExtensible {
    public Result() {
    }

    private string _cookie;

    [global::ProtoBuf.ProtoMember( 1, IsRequired = true, Name = @"cookie", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public string Cookie {
      get { return _cookie; }
      set { _cookie = value; }
    }

    private byte[] _resultBytes;

    [global::ProtoBuf.ProtoMember( 2, IsRequired = true, Name = @"result_bytes", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public byte[] ResultBytes {
      get { return _resultBytes; }
      set { _resultBytes = value; }
    }

    private bool _success;

    [global::ProtoBuf.ProtoMember( 3, IsRequired = true, Name = @"success", DataFormat = global::ProtoBuf.DataFormat.Default )]
    public bool Success {
      get { return _success; }
      set { _success = value; }
    }

    private global::ProtoBuf.IExtension extensionObject;

    global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject( bool createIfMissing ) {
      return global::ProtoBuf.Extensible.GetExtensionObject( ref extensionObject, createIfMissing );
    }
  }

}

public class SerializerHelper {

  public static T Deserialize<T>(System.IO.MemoryStream stream) {
    return default(T);
  }

  public static void Serialize<T>(System.IO.MemoryStream stream, T entity) {
    return;
  }

}

