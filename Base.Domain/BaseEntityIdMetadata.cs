using Base.Contracts.Domain;

namespace Base.Domain;

public abstract class BaseEntityIdMetadata: BaseEntityIdMetadata<Guid> 
{
}

public abstract class BaseEntityIdMetadata<TKey> : BaseEntityId<TKey>, IDomainEntityMetadata
    where TKey: IEquatable<TKey>
{
    public string CreatedBy { get; set; } = null!;
    public DateTime CreatedAt { get; set; }
    public string UpdatedBy { get; set; } = null!;
    public DateTime UpdatedAt { get; set; }
}