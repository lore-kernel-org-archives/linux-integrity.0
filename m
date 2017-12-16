Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from sequoia-grove.ad.secure-endpoints.com ([208.125.0.235]:57198
        "EHLO smtp.secure-endpoints.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757207AbdLPQ2q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 16 Dec 2017 11:28:46 -0500
Subject: Re: [PATCH v2 05/19] afs: convert to new i_version API
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20171216134656.15561-1-jlayton@kernel.org>
 <20171216134656.15561-6-jlayton@kernel.org>
 <1513432186.3428.6.camel@kernel.org>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, bfields@fieldses.org, neilb@suse.de,
        jack@suse.de, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-xfs@vger.kernel.org,
        darrick.wong@oracle.com, david@fromorbit.com,
        linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com, linux-integrity@vger.kernel.org,
        zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        linux-afs@lists.infradead.org, dhowells@redhat.com
From: Jeffrey Altman <jaltman@auristor.com>
Message-ID: <82157aa3-ec0b-25e6-517b-704a3f81ec61@auristor.com>
Date: Sat, 16 Dec 2017 11:18:41 -0500
MIME-Version: 1.0
In-Reply-To: <1513432186.3428.6.camel@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms030408000205080100010300"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Jeff,

A few thoughts on AFS usage below which might impact a future revision
of the API.  I hope they are useful.

On 12/16/2017 8:49 AM, Jeff Layton wrote:
> On Sat, 2017-12-16 at 08:46 -0500, Jeff Layton wrote:
>> From: Jeff Layton <jlayton@redhat.com>
>>
>> For AFS, it's generally treated as an opaque value, so we use the
>> *_raw variants of the API here.
>>
>> Note that AFS has quite a different definition for this counter. AFS
>> only increments it on changes to the data, not for the metadata. We'll
>> need to reconcile that somehow if we ever want to present this to
>> userspace via statx.
>>

From the patch series notes:

"The inode->i_version field is supposed to be a value that changes
whenever there is any data or metadata change to the inode. Some
filesystems use it internally to detect directory changes during
readdir. knfsd will use it if the filesystem has MS_I_VERSION set. IMA
will also use it to optimize away some remeasurement if it's available.
NFS and AFS just use it to store an opaque change attribute from the
server.

"Only btrfs, ext4, and xfs increment it for data changes. Because of
this, these filesystems must log the inode to disk whenever the
i_version counter changes. That has a non-zero performance impact,
especially on write-heavy workloads, because we end up dirtying the
inode metadata on every write, not just when the times change. [1]"


The AFS/AuriStorFS data version is an unsigned 64-bit value that is
incremented by the file server as part of a data changing operation. For
files, a StoreData and for directories entry manipulations such as
create, rename, delete.  This data version is used to tag the version of
any subset of the data stream for caching and replication purposes.

As Jeff notes, the AFS data version is not incremented for metadata
changes.  Metadata cannot be trusted by clients without acquiring a
callback promise from a fileserver.  The callback promise will either be
satisfied by the issuing fileserver sending a CallBack notification that
the metadata is no longer valid OR the callback promise will expire.

Something else that is important to note that it is assumed that local
data changes that occur under a valid callback promise is newer than the
data on the fileserver.  It might be useful if the new i_version API
supported major and minor version numbers.  AFS implementations would
store the fileserver provided data version number as the major version
and would increment the minor version when local changes have been made
which have yet to be stored back to the fileserver.  This functionality
would be especially useful if disconnected operations were implemented
for the AFS implementation.

It might also be useful to separate metadata version and data version
although some filesystems would set the same value to both.  For AFS,
the metadata major version would the timestamp at which the callback was
issued.

Jeffrey Altman


    [ Part 1.2, Text/X-VCARD (Name: "jaltman.vcf") ~18 lines. ]
    [ Unable to print this part. ]


    [ Part 2, "S/MIME Cryptographic Signature" ]
    [ Application/PKCS7-SIGNATURE (Name: "smime.p7s") 4.1 KB. ]
    [ Unable to print this part. ]
