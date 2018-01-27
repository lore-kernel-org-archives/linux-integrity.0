Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51090 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751905AbeA0RJX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jan 2018 12:09:23 -0500
Message-ID: <1517072939.3012.23.camel@HansenPartnership.com>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] fs-verity: file system-level integrity
 protection
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andreas Dilger <adilger@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Sat, 27 Jan 2018 09:08:59 -0800
In-Reply-To: <1517069959.3012.13.camel@HansenPartnership.com>
References: <20180125191152.GA11197@thunk.org>
         <1516927666.4082.25.camel@HansenPartnership.com>
         <20180126023054.GC31091@thunk.org>
         <1516942235.4082.52.camel@HansenPartnership.com>
         <20180126145856.GA2841@thunk.org>
         <1516985067.4000.10.camel@HansenPartnership.com>
         <20180126215540.GA23308@thunk.org>
         <275E5E86-635E-4D79-9AC9-3D24318EDDDF@dilger.ca>
         <1517069959.3012.13.camel@HansenPartnership.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Y/2MHM2cYBl83hfNKNO+"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[cc'ing linux-integrity, since they're the experts]

On Sat, 2018-01-27 at 08:19 -0800, James Bottomley wrote:
> On Sat, 2018-01-27 at 00:58 -0700, Andreas Dilger wrote:
> > 
> > On Jan 26, 2018, at 2:55 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > > 
> > > 
> > > 
> > > On Fri, Jan 26, 2018 at 08:44:27AM -0800, James Bottomley wrote:
> > > > 
> > > > 
> > > > On Fri, 2018-01-26 at 09:58 -0500, Theodore Ts'o wrote:
> > > > > 
> > > > > 
> > > > > Docker save was going to have to be altered to use IMA,
> > > > > anyway.
> > > > 
> > > > Actually, no, that's not entirely true[1].  Docker save
> > > > produces a tar file.  Once the tar on your platform picks up
> > > > xattrs, docker save just works for container images with IMA
> > > > hashes and signatures (and selinux labels, which was actually
> > > > the driver for the change).  The point at which the ecosystem
> > > > changed to "just work" was the point at which tar understood
> > > > xattrs.  That's why I was poking on how do we get tar to
> > > > understand this format, following on the way IMA and selinux
> > > > did it.  There may be another way of getting this change into
> > > > the ecosystem, but ecosystem adoption has to be part of the
> > > > considerations for this.
> > > 
> > > Oh, I see.  You are saying that you want to be able to use tar to
> > > backup integrity protected files, and then restore them later.
> > > 
> > > Yes, that's different from what I was assuming, which is a model
> > > where the integrity protect file would be written by some package
> > > manager (e.g,. rpm, dpkg, the code that downloads the apk, etc.),
> > > and that we would *not* be trying to backup the file with the
> > > integrity data, and then restore it later via some kind of untar
> > > operation.
> > > 
> > > The problem here is that a merkle tree simply won't fit inside an
> > > xattr for any non-trivail file.  And there may be use cases where
> > > blocking the open until the integrity is verifeid on the entire
> > > file. However, there are uses cases where the a signifcant
> > > increase in the open latency can't be tolerated, and wher the
> > > file might have might have large portions of dat which will never
> > > be read, and thus, don't need to have their integrity
> > > verified.  (Example: an APK might have megabytes and megabytes of
> > > translation resources for N languages, only one of which will
> > > normally be used by a particular user on a particular phone.  Or
> > > as another example, an ELF binary that has huge portions of
> > > symbol table and debugging information that is normally not
> > > used.)
> > > 
> > > So the requirement that you must be able to backup an integrity
> > > protected file, and then restore it again, without modifying the
> > > tool which does the backup and restore, does certainly push you
> > > towards using xattrs.  But xattrs force the huge open latency,
> > > and while Docker is big in some circles, there are lots of use
> > > cases where the unmodified backup/restore requiremnt is simply
> > > not applicable.
> > > 
> > > So perhaps there is room for both solutions.
> > 
> > I think this is relatively straight forward to handle.  The package
> > (tarball, whatever) itself only needs to store the top-level
> > checksum, since this validates the whole Merkle tree, and in turn
> > the integrity of the whole file.  This is exactly what Bittorrent
> > does for files.
> 
> Well, not quite: bittorrent doesn't reconstruct the hash from the
> file, it downloads the hash a piece at a time and uses that to verify
> the piece of the file it's obtained.  However, I accept that's only
> because the leechers don't have the whole file from which to
> reconstruct the hash; seed creation certainly does this.
> 
> > 
> > When the package is extracted, the Merkle tree can be regenerated
> > and written with the file for random IO access using fs-
> > verity.  When the Merkle tree is written to disk, the top-level
> > checksum is verified against the checksum stored in the package to
> > ensure it was written correctly.  This means only a small checksum
> > needs to be stored in the archive (32 bytes), but an integrated
> > system will have end-to-end data verification.
> 
> I certainly buy this approach, and it fits well with the limited data
> size there is in xattrs but Ted said in the initial proposal the
> entire tree would be present in the file.  I can't see a need for
> supplying the entire tree rather than reconstructing it but maybe
> there's an android use case I'm not seeing (Like not wanting to waste
> limited CPU power).
> 
> Just so I understand the mechanics: The xattr would contain the head
> node.  When this is written, the tree would be reconstructed from the
> file and verified.  If it verifies, it must be stored in the
> filesystem data somehow (or at least the lowest layer), so all
> subsequent uses of the file can proceed from the per page hash even
> after unmount and remount?  Then I certainly think it suits both
> cases.

Just adding to this: it looks like the merkle tree could be an internal
thing only depending on whether the filesystem supported it and whether
the user wanted this mode of verification (likely because of the space
it takes in the filesystem) because you can also construct a merkle
tree from a standard IMA signed hash, so there's no real need for a new
external format.

James


    [ Part 2, "This is a digitally signed message part" ]
    [ Application/PGP-SIGNATURE (Name: "signature.asc") 235 bytes. ]
    [ Unable to print this part. ]
