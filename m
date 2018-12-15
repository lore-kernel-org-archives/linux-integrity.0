Return-Path: <SRS0=MTCy=OY=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFA9C43387
	for <linux-integrity@archiver.kernel.org>; Sat, 15 Dec 2018 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB27206A2
	for <linux-integrity@archiver.kernel.org>; Sat, 15 Dec 2018 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbeLOLHh (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 15 Dec 2018 06:07:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:57709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbeLOLHg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 15 Dec 2018 06:07:36 -0500
Received: from pegasus6.linux ([188.194.7.253]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3R1g-1hOiPS3PhA-00r19F; Sat, 15
 Dec 2018 12:07:22 +0100
Subject: Re: Bug: Persisting O_TMPFILE with IMA
To:     Mimi Zohar <zohar@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, Fabian Vogt <fvogt@suse.de>
References: <884653bf-2e25-b78f-2dc7-51c5a57d4b51@suse.de>
 <1544814096.3681.12.camel@linux.ibm.com>
From:   Ignaz Forster <ignaz.forster@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=ignaz.forster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8dd90198-00ef-a43f-194b-9c4dcfc2227a@gmx.de>
Date:   Sat, 15 Dec 2018 12:07:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <1544814096.3681.12.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="s9yWgJEWuJulYoiovA33sVL10W67ZbKpL"
X-Provags-ID: V03:K1:8rpahrjRFFb+j+DikQelQj+3jfFzz3uXanVBRXNFaKhOfvcsSaw
 GZ3/o1PQHAdc1XVSP0bqwgVIAu2zm8dIBjF+3YGE22GOGRcli4HHiF+aLyduWVEjePdui1Q
 +NTzlw3mLE0prYmOAdqE1PbTJe+oSOJuzoJ/YgcLKSH+lEnhC/ussNGadT4/vkbfA+AhHQB
 tLIWhZBVwanrp3u3hGQAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:epMLc1MF2oM=:2ls4JGA99zOYsPpr2eU4qi
 GWpW12NWVIuOxMBppg8PJ1YozH6LYabOokaxgOf63A/qrKvVmXi7kJnS9M7eus4fM6i7pz909
 6nCNzwPKYgSCnFQdrQfDHN6AxOZY93lN4SikgShqTe7UuebSA3HCAXJnF3jqP9cZJXXEqh/k9
 mcqoBng11amM0Wr9ZkrWT6ij/ERb5N9knxTqw9IzPxcNk8CGbJK59Bgiyvl0nSf9c6hEJHrQ8
 13OnVST0o+8j/CsEWMNtYqxGYQghHXdM76uPSfRl1R841+jqsxlYv1XJ0lJx2PaN6zBbXTRjf
 AgBUsm9HBIclJbuvQaN1m9Zn6qzedtX21XnyhExYg9s5uvMVt/PRg24kJak+hvDmU93d/KJui
 myKmF6JbJBgN0J8+JMD+UdWZSEaa2qRl/m3Kju2iLoSk+5UfKK2IINVHMOiiUOSf173DNJH3g
 v6ysrHI6ejNG6rMh9wsskG6B330Nw+mLYNYWzf6uRAovxZ2sBqOfTSnDdukSlO/kIl6i5bOUg
 DhwS5U/6RaQ2f+kp6leHfBbGLEQjv/jAhEzdyNjX0l5SLfYztFuAAUprDPsTjTLyUZrjXynT/
 eC1OPVXf8sJg0E/E8Rc5tQf6ffUgASv16PNL5/qdInuQxOPw66sMj18dv3lmsS+lwwTzN94Sl
 37+4tOQoqgB7LVt7vdn0QpYjkFM8M7v9Yi18vPLHnTdxlt3DkT4RJfkUBsAUrohLrLu8LidNQ
 Ndi8ktfTUn6SUX4+5lgkqDo4v1yR0rlZzc6h/cvVpHSTbTkF4kFIPA/RnOHEqV1e2T67hfCNi
 dgCtm65U0YFdldvlYLwczJOTyi8ebX8eBuFe/yWOG2GrLG7MydS4VxWgyLkM2MY+W3+9WDSxk
 0LLQn3LsEO/0wKcw7uGNQoSo7xWRGQPVrXVlOOmKTqfvo9Su98AQfuXTtT54Fe
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s9yWgJEWuJulYoiovA33sVL10W67ZbKpL
Content-Type: multipart/mixed; boundary="GygjA9pkePLKC34MuIwMmMq8GpPd8eMwS";
 protected-headers="v1"
From: Ignaz Forster <ignaz.forster@gmx.de>
To: Mimi Zohar <zohar@linux.ibm.com>, zohar@linux.vnet.ibm.com,
 linux-integrity@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>, Fabian Vogt <fvogt@suse.de>
Message-ID: <8dd90198-00ef-a43f-194b-9c4dcfc2227a@gmx.de>
Subject: Re: Bug: Persisting O_TMPFILE with IMA
References: <884653bf-2e25-b78f-2dc7-51c5a57d4b51@suse.de>
 <1544814096.3681.12.camel@linux.ibm.com>
In-Reply-To: <1544814096.3681.12.camel@linux.ibm.com>

--GygjA9pkePLKC34MuIwMmMq8GpPd8eMwS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Mimi Zohar schrieb am 14.12.2018 um 20:01 Uhr:
> On Fri, 2018-12-14 at 19:11 +0100, Ignaz Forster wrote:
>> Hello,
>>
>> persisting files opened with O_TMPFILE doesn't seem to work on IMA as =

>> expected: The IMA xattr won't be written. This makes it impossible to =

>> access the file later.
>> The following example application, based on the O_TMPFILE example from=

>> 	man 2 open
>> will demonstrate this:
>>
>>
>> #include <fcntl.h>
>> #include <unistd.h>
>> #include <linux/limits.h>
>> #include <stdio.h>
>>
>> int main(int argc, char *argv[]) {
>> 	char path[PATH_MAX];
>> 	int fd =3D open("/tmp", __O_TMPFILE | O_RDWR, S_IRUSR | S_IWUSR);
>> 	write(fd, "test", 4);
>> 	snprintf(path, PATH_MAX, "/proc/self/fd/%d", fd);
>> 	linkat(AT_FDCWD, path, AT_FDCWD, "/tmp/tmpfile_persisted.txt",
>> 			AT_SYMLINK_FOLLOW);
>> }
>>
>>
>> (/tmp should not be a tmpfs of course; change to paths to a supported =

>> file system if necessary.)
>>
>> This was discovered when trying to understand why IMA is failing on=20
>> overlayfs during truncated copy_up operations (see thread "PROBLEM: IM=
A=20
>> xattrs not written on overlayfs" from September / October), though thi=
s=20
>> is probably a different problem.
>=20
> rootfs is a tmpfs filesystem. =C2=A0Once CPIO supports xattrs, they can=
 be
> included in the initramfs.
>=20
> Remember the builtin policies - ima_policy=3Dtcb|appraise_tcb - are
> there from boot. =C2=A0They are meant to be replaced with finer grained=

> policies based on LSM labels, once the LSMs are up and running.
>=20
> Feel free to replace the builtin IMA policy with one to your liking.

I'm not talking about the initrd or the early boot process here - the=20
application will fail when compiling and executing it in a fully started =

system. It will just open a temporary file without a name, write somethin=
g=20
into it and save it to "/tmp/tmpfile_persisted.txt", following the exampl=
e=20
for using O_TMPFILE in the open(2) manpage. No IMA hash will be generated=
=20
for the file, making the file inaccessible and thus breaking applications=
=20
relying on this feature of O_TMPFILE (though I assume that's not widely=20
used yet).

Ignaz


--GygjA9pkePLKC34MuIwMmMq8GpPd8eMwS--

--s9yWgJEWuJulYoiovA33sVL10W67ZbKpL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEExhuDDPaobZOSSxz1uuuxltLcCxkFAlwU4GkACgkQuuuxltLc
CxnDCRAApL4q+12j0TvREmOQdPqT6l+LPDPJY6ScNAMVSHA0SlIlC95zYwF0GqRT
rZ8V59Z8LNREOILudWtDmHDjbNIKFC4IEh1TindvBlQKiIQv78Y3mwhQBG9Mdtey
KSfoIau+GOcm0t++XQNgLe0CKilFB2/akI3Ay+aYUWTuPdSrUQjyEnsLzHww8Rgw
lGh9IL9NBSYXs6yznB1gq6h8tdtBBWbVuUgjiOvXaprENPLwqEofJvBCFIh6Ymh4
j/pSNzdshO8Y/Kig2BsnwhvPYWRP1zu6QYXpMVCFoao12u3b7vZYLSswe+pMMSJL
KB4EsHKtZW8RRwXFw1+2NPRrJrtx0YEpnc/lvuLpRclW1RQo9MapOmrFI/iOjGyG
/ghYcp30bdJkd+jDEXGHLhfebULVZB0JQgFtlotH+P+PeNik5xOlr4lbH+Jq3/2u
h2LH/km0uHTRpUMGtY+ZrogD8E+5seJyZipGpe/RUtBPEP6ZsLdZXQbr2nxKSDX6
yNh5Q0dR33oDILQJPSI5CWs1vk+KXtquXJBe44jpgDMqMK2+4xBgpOsB6AI6DmFY
er4zCIvZe2ztsBV9Auq9OGwGaFmJMISLgyCkRC98XaSSMNjjt/MV8kZNHZJ54O+7
Pkdnas7ZgxjqVob+Tn77dbrAtxdaLzvsg/Nq4jXXUVlH0cyMRKQ=
=DLua
-----END PGP SIGNATURE-----

--s9yWgJEWuJulYoiovA33sVL10W67ZbKpL--
