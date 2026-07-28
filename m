Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771733938A
	for <linux-integrity@vger.kernel.org>; Tue, 28 Jul 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227138; cv=none; b=rBTuxsdx85B6U/qKvnZjxGKni5155QCTnz3FTXHuEVRU8P9NDZgv+4jne5/tjSFWB2eceUojTdYzT0pZ7cDjQRUOCDRcLggVU76uAL/lOR1rl30EcPeC6F8A882K34dn3/TwehGC6bKnboym3TQu0SO0bmyI482VsAClRpaBLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227138; c=relaxed/simple;
	bh=Dz4TKbW+jrWkmEyor9VIt5m7Myhlb4gXcMzNB0s5HdU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HghSAjIq8YyXgZ/ySpMdt7JLquaR39CAY+qfVRZmTpZ3EWi1mL7gdrjnJgD56KfSQ8j60jcmYyH9ltM+qxsMJyCkWFFObhDIiuE3Dw+nqF6VJPjrCMyDvs1Ynn+fOiK4ty+5JttAQrxtGu86cE7b90iP8TtmVoLwlfVLeJ4m9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h8Scp5jGBzt00p
	for <linux-integrity@vger.kernel.org>; Tue, 28 Jul 2026 16:02:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id EF38C40562
	for <linux-integrity@vger.kernel.org>; Tue, 28 Jul 2026 16:08:51 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with UTF8SMTPA id LxC2BwAH0tqOY2hqHScgAA--.8611S2;
	Tue, 28 Jul 2026 09:08:51 +0100 (CET)
Message-ID: <0e1a23930f101b77c4c94a67543e4cffc34de19e.camel@huaweicloud.com>
Subject: Re: zohar@linux.ibm.com, roberto.sassu@huawei.com
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Fabrice Derepas <fabrice.derepas@canonical.com>, 
	linux-integrity@vger.kernel.org
Date: Tue, 28 Jul 2026 10:08:44 +0200
In-Reply-To: <CAD2AHCbuQyKwR27hNcYRhU7njCeigmQoL9x9i25zb0N5-8Kx+A@mail.gmail.com>
References: 
	<CAD2AHCbuQyKwR27hNcYRhU7njCeigmQoL9x9i25zb0N5-8Kx+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAH0tqOY2hqHScgAA--.8611S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1DGFWUGr1xGw18Xr1fJFb_yoWfKFWrpF
	ZIkF47Jr1DJFyUAry2ya1fCa4F9a4DJ3yUG34rGw1Iyan09rsavrWxtryrurWrZr97Jrn8
	tayqgr4kC3Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBGpoVWwC5wADsQ

On Sat, 2026-07-18 at 08:52 +0200, Fabrice Derepas wrote:
> evm_read_protected_xattrs() accepts a buffer_size parameter but never
> validates it on the 'n' (names) and 'l' (lengths) paths.  The sole
> in-tree caller, ima_eventinodexattrs_init_common(), uses a lock-free
> measure-then-allocate-then-fill pattern across two separate calls.  A
> concurrent write to /sys/kernel/security/integrity/evm/evm_xattrs
> between the measure and fill calls causes the fill to iterate more
> xattr entries than the buffer was sized for, producing a heap write
> past the end of the allocation.

Hi Fabrice

thanks for reporting the bug.

I need to say, also for everybody, please don't send AI-style bug
reports. I would like to receive a kernel-style commit message
explaining the problem and the solution in just a few sentences. Also,
for the next iteration, please make a real patch.

Thanks

Roberto

> Affected code
> -------------
> security/integrity/evm/evm_main.c, evm_read_protected_xattrs(),
> lines 374-425.
>=20
> The 'n' path writes at line 395 without checking total_size + size
> <=3D buffer_size.  The 'l' path stores a u32 at line 404 with the same
> omission.  The 'v' path at line 413 correctly passes
> (buffer_size - total_size) to __vfs_getxattr(), so the omission on
> the other two paths is inconsistent with clear design intent:
>=20
> switch (type) {
> case 'n':
> size =3D strlen(xattr->name) + 1;
> if (buffer) {
> if (total_size)
> *(buffer + total_size - 1) =3D '|';
>=20
> memcpy(buffer + total_size, xattr->name, size); /* line 395 -- no
> bounds check */
> }
> break;
> case 'l':
> size =3D sizeof(u32);
> if (buffer) {
> if (canonical_fmt)
> rc =3D (__force int)cpu_to_le32(rc);
>=20
> *(u32 *)(buffer + total_size) =3D rc;              /* line 404 -- no
> bounds check */
> }
> break;
> case 'v':
> size =3D rc;
> if (buffer) {
> rc =3D __vfs_getxattr(dentry,
> d_backing_inode(dentry), xattr->name,
> buffer + total_size,
> buffer_size - total_size);               /* line 413 -- has bounds check =
*/
> if (rc < 0)
> return rc;
> }
> break;
>=20
>=20
> Root cause
> ----------
> Two defects combine:
>=20
> (1) Missing bounds check (function-level): the 'n' and 'l' paths write
>     into buffer + total_size without verifying total_size + size <=3D
>     buffer_size.  The buffer_size parameter is accepted but unused on
>     these paths.
>=20
> (2) TOCTOU race (caller-level): ima_eventinodexattrs_init_common()
>     in ima_template_lib.c:703 calls evm_read_protected_xattrs() twice,
>     separated by a kmalloc():
>=20
>         line 713: rc =3D evm_read_protected_xattrs(..., NULL, 0, ...);
>         line 718: buffer =3D kmalloc(rc, GFP_KERNEL);
>         line 722: rc =3D evm_read_protected_xattrs(..., buffer, rc, ...);
>=20
>     list_for_each_entry_lockless() provides RCU read-side traversal but
>     does not stabilise the list across two separate calls.  A concurrent
>     list_add_tail_rcu() in evm_write_xattrs() (evm_secfs.c:263) between
>     lines 713 and 722 causes the fill call to see more entries than the
>     buffer accommodates.
>=20
>     Note: xattr_list_mutex (evm_secfs.c:24) is held only by the writer;
>     there is no read-side lock that would prevent the list from changing
>     between the two calls.
>=20
> Neither defect alone is exploitable: without the race, buffer_size
> equals the measured size; without defect (1), an overflow would be
> caught.  Together they produce a controlled heap write past the
> allocation.
>=20
>=20
> Reachability
> ------------
> Write path: evm_write_xattrs() (evm_secfs.c:179) handles writes to
> /sys/kernel/security/integrity/evm/evm_xattrs.  It requires
> CAP_SYS_ADMIN and evm_xattrs_locked =3D=3D 0 (checked at line 188).
> This path is only compiled when CONFIG_EVM_ADD_XATTRS=3Dy.
>=20
> Read path: ima_eventinodexattrs_init_common() is called during IMA
> event logging for templates that include xattrnames or xattrlengths
> fields (e.g. a custom template with 'n' or 'l' fields).  This runs
> on any file access (open, exec, mmap) matched by the active IMA
> policy.
>=20
> Concrete scenario:
>=20
>   1. IMA policy active with a template including xattrnames ('n').
>   2. Initial xattr list: security.selinux (17+1 bytes),
>      security.ima (12+1 bytes) -- measure call returns 31.
>   3. kmalloc(31) allocates the buffer.
>   4. CAP_SYS_ADMIN process writes security.apparmor and
>      security.capability to evm_xattrs before the fill call.
>   5. Fill call iterates 4 entries, needs ~62 bytes -- overflows
>      the 31-byte allocation.
>=20
> The attacker controls write timing and can trigger IMA measurements
> on demand (e.g. by opening a file matching the IMA policy), making
> the race window practically reliable.
>=20
>=20
> Reproducer
> ----------
> The following reproduces the race by simulating the list growth
> between the two calls.  Tested with gcc -fsanitize=3Daddress.
>=20
>   /*
>    * repro_evm_oob.c
>    * Compile: gcc -fsanitize=3Daddress -g -o repro_evm_oob repro_evm_oob.=
c
>    * Run:     ./repro_evm_oob
>    */
>   #include <stdint.h>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <stdio.h>
>=20
>   typedef uint32_t u32;
>=20
>   struct xattr_entry {
>       const char *name;
>       int         xattr_size;
>       struct xattr_entry *next;
>   };
>=20
>   static struct xattr_entry *xattr_head =3D NULL;
>=20
>   static void add_xattr(const char *name, int sz)
>   {
>       struct xattr_entry *e =3D malloc(sizeof(*e));
>       e->name =3D name; e->xattr_size =3D sz; e->next =3D NULL;
>       if (!xattr_head) { xattr_head =3D e; }
>       else {
>           struct xattr_entry *p =3D xattr_head;
>           while (p->next) p =3D p->next;
>           p->next =3D e;
>       }
>   }
>=20
>   /* Mirrors evm_main.c:374-425 for type=3D'n'. buffer_size is accepted
>    * but never checked -- the bug. */
>   static int evm_read_protected_xattrs_sim(uint8_t *buffer,
>                                            int buffer_size, char type)
>   {
>       struct xattr_entry *xattr;
>       int rc, size, total_size =3D 0;
>=20
>       for (xattr =3D xattr_head; xattr; xattr =3D xattr->next) {
>           rc =3D xattr->xattr_size;
>           if (rc < 0) continue;
>           switch (type) {
>           case 'n':
>               size =3D strlen(xattr->name) + 1;
>               if (buffer) {
>                   if (total_size)
>                       *(buffer + total_size - 1) =3D '|';
>                   /* BUG: no check that total_size + size <=3D buffer_siz=
e */
>                   memcpy(buffer + total_size, xattr->name, size);
>               }
>               break;
>           default:
>               return -1;
>           }
>           total_size +=3D size;
>       }
>       return total_size;
>   }
>=20
>   int main(void)
>   {
>       /* Initial list: 2 entries */
>       add_xattr("security.selinux", 42);
>       add_xattr("security.ima", 32);
>=20
>       /* Measuring call (buffer=3DNULL) */
>       int measured =3D evm_read_protected_xattrs_sim(NULL, 0, 'n');
>       printf("[1] measured=3D%d\n", measured);
>=20
>       uint8_t *buf =3D malloc(measured);
>       if (!buf) return 1;
>=20
>       /* TOCTOU: list grows before fill call */
>       add_xattr("security.apparmor", 100);
>       add_xattr("security.capability", 20);
>=20
>       /* Filling call -- overflows */
>       printf("[2] filling...\n");
>       int rc =3D evm_read_protected_xattrs_sim(buf, measured, 'n');
>       printf("[3] wrote %d into %d-byte buffer\n", rc, measured);
>=20
>       free(buf);
>       return 0;
>   }
>=20
> Observed ASan output:
>=20
>   ERROR: AddressSanitizer: heap-buffer-overflow on address 0x...
>   WRITE of size 18 at 0x... thread T0
>       #0 in memcpy ...
>       #1 in evm_read_protected_xattrs_sim repro_evm_oob.c
>       #2 in main repro_evm_oob.c
>=20
>   0x... is located 0 bytes after 30-byte region [0x..., 0x...)
>   allocated by thread T0 here:
>       #0 in malloc ...
>       #1 in main repro_evm_oob.c
>=20
>=20
> Impact
> ------
> Heap write past an allocation.  The attacker chooses the xattr names
> (write content) and the number of entries added (write size).
> Consequence ranges from a kernel crash (DoS) to, with heap layout
> control, a potential privilege escalation.
>=20
> Requirements: CAP_SYS_ADMIN (to write evm_xattrs), CONFIG_EVM=3Dy,
> CONFIG_IMA=3Dy, CONFIG_EVM_ADD_XATTRS=3Dy, and an active IMA policy
> with a template containing xattrnames or xattrlengths fields.
> CAP_SYS_ADMIN inside a user namespace may suffice on configurations
> that permit it.
>=20
>=20
> Proposed fix
> ------------
> Add bounds checks to the 'n' and 'l' paths, mirroring the existing
> check on the 'v' path:
>=20
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -388,6 +388,8 @@
>   case 'n':
>   size =3D strlen(xattr->name) + 1;
>   if (buffer) {
> + if (total_size + size > buffer_size)
> + return -ERANGE;
>   if (total_size)
>   *(buffer + total_size - 1) =3D '|';
>=20
> @@ -398,6 +400,8 @@
>   case 'l':
>   size =3D sizeof(u32);
>   if (buffer) {
> + if (total_size + size > buffer_size)
> + return -ERANGE;
>   if (canonical_fmt)
>   rc =3D (__force int)cpu_to_le32(rc);
>=20
> A note on the return value: I have used -ERANGE rather than
> returning total_size (partial bytes written).  The caller in
> ima_eventinodexattrs_init_common() treats negative returns as an
> error and falls through to kfree(buffer) without logging partial
> data, which is a safer failure mode than silently recording a
> truncated xattr list.  The TOCTOU race that triggers the overflow
> is also an integrity anomaly (the xattr list changed under us), so
> treating it as an error rather than silently truncating seems
> correct.  Maintainer preference on the return value is welcome.
>=20
> An alternative fix at the caller level would be to hold
> xattr_list_mutex around both calls in
> ima_eventinodexattrs_init_common(), but this requires exposing the
> mutex and the function-level bounds check is more robust against
> future callers.
>=20
>=20
> How this was found
> ------------------
> Found by applying the Squeeze Loop strategy ("The Squeeze Loop
> Strategy: Catching Coherent-and-Wrong Artifacts with an
> Author-Independent Executable Oracle," Zenodo DOI 10.5281/zenodo.20787816=
,
> 2026) on its C terrain - the deductive-verification analogue of
> the paper's Rust application.
>=20
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>

