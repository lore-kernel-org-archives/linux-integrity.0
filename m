Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C247D951
	for <linux-integrity@vger.kernel.org>; Wed,  5 Aug 2026 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945701; cv=none; b=jf3xYmE/Sjdo24U/1HACQ2buNZe4FN+5A8f59vSIc+5K5tm0oGvXwxwrP+3Psh5yg2oDuUKu4gjK6bGAguoQAXhP8MQYpNXJLEj5WQI61noy4Gn36pcfuUvgakYm4Mew6DY5NGndEDm+dTdDJVm5LPjbBeZiOvFkC/fe6Lxa130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945701; c=relaxed/simple;
	bh=xAbaVHxc2dMOzrDQrzk6m+BmC0sNBSR4flGgtHWvDMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpshsU5pqEIuJ+XM8ZRRsq8fdAmo9BAE7hVXBSCWtrDHi+EiRPopPriO4e+b31CGlxabydJitqYsVq0UlcSjKW4ucBt2FZWGPFv7HX9GTg+qt9+M6tL1Wb3H5i9ywfAb2zJ6tMZedcD6GKkvC1K8oaL0Wb+/57/fLXVYfRQRU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCP3luce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCP3luce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6089A1F000E9
	for <linux-integrity@vger.kernel.org>; Wed,  5 Aug 2026 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785945696;
	bh=GsmC6QA8gkvnd3hLSg9Klgxkzd6KUrmOUb1n5QfNqYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NCP3luceVZjP+YRbFN732Z8MY1iXD9lZIaDJx8RdmXDnrAA6aNbIN8x0D99bSwj+n
	 X8cvaQNXEuKMGlZ0AQHEhMrGEQmWbz31y6CXhkKqnxkK/JPWfvFYTz+fTVB9r2RSmu
	 PSUU3A7oJOAK0m5til5+4E8i9a2Zm+OQhLTY8d5NPHUM8i1CcZdu+XCSN1hDId51Z+
	 ISAV6KFWshUdKl6IXXTCBcnZzKrTg42ZKwYCpHQRuJF+jfM3101e0kEitfAXZTNDm8
	 Zr5TEyWfnueChba5yKvkL/RhF7Pa4x+NW1kbdlzj4CribtBZ0+LBcuFsT/o4QWwkQq
	 tokZQdab3WBLw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so12293e87.1
        for <linux-integrity@vger.kernel.org>; Wed, 05 Aug 2026 09:01:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrzRYjB+G2Zdr8nwxv82jgTpPvosSL8tKsIbFK2QnMCS3NqeDDjWQLU5rFaMgUne/SOp1fRPNC7ICS88ezqjbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9NIM2tkQVFxaZpHZmctX+AtDYh7ZmsbwA2QXkZitLLiySI4/
	/I3UgcUAUoNW1s8s9FCm3wSzqWR6ijq4HpkUuXdwYikfMoR57/w58GkVPE8b+T8FWjEZdDWeTJ6
	TMsHLQ0joGLQEKf/l/L4wUAzyU6wwoow=
X-Received: by 2002:ac2:4c53:0:b0:5b2:aad1:7dc2 with SMTP id
 2adb3069b0e04-5b2fe7bec59mr27783e87.21.1785945694862; Wed, 05 Aug 2026
 09:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com>
In-Reply-To: <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 18:01:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
X-Gm-Features: AUfX_myW7xu4tnlSo8vBz4hdbtZoOseDwqKUO260JwpnpQ0OYqDFe4bcn4eCJH4
Message-ID: <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver to
 a platform one"
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Julien <julien82453@gmail.com>, regressions@lists.linux.dev, jarkko@kernel.org, 
	linux-integrity@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000bb187606584ee296"

--000000000000bb187606584ee296
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 9:08=E2=80=AFPM Wysocki, Rafael J
<rafael.j.wysocki@intel.com> wrote:
>
> Hi,
>
> On 8/2/2026 2:54 PM, Julien wrote:
> > Hello,
> >
> > Please keep in mind this is my first time reporting a Linux kernel
> > regression.
> >
> > Since commit 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform
> > one"), my TPM device is no longer available. Both /dev/tpm0 and
> > /dev/tpmrm0 are missing.
> >
> > Log messages:
> > platform MSFT0101:00: failed to claim resource 1: [mem
> > 0xfed40000-0xfed40fff]
> > acpi MSFT0101:00: platform device creation failed: -16
> >
> So there's no platform device for the driver to bind to.
>
> I think that these messages have been present in the kernel logs for
> quite some time, but previously they were not connected to any
> functional issues.
>
>
> > I added some debug logging:
> > ACPI resourcet[0] =3D [mem 0xfed40040-0xfed4103f flags 0x200]
> > ACPI resourcet[1] =3D [mem 0xfed40000-0xfed40fff flags 0x200]
> >
> > I think the failure happens in kernel/resource.c: __insert_resource()
> > because of the two memory regions overlapping.
> >
> This is quite plausible, but if that's the case, it should be fixable.
>
> Let me figure out something.

Please try the attached patch and let me know how it goes.

It applies on top of the current mainline, but it may be adjusted to
older kernels, so please let me know if you need that.

--000000000000bb187606584ee296
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-platform-adjust-resources.patch"
Content-Disposition: attachment; 
	filename="acpi-platform-adjust-resources.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msg9rd8a0>
X-Attachment-Id: f_msg9rd8a0

LS0tCiBkcml2ZXJzL2FjcGkvYWNwaV9wbGF0Zm9ybS5jIHwgICAzOSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKLS0tIGEvZHJpdmVycy9hY3BpL2FjcGlfcGxhdGZvcm0uYworKysg
Yi9kcml2ZXJzL2FjcGkvYWNwaV9wbGF0Zm9ybS5jCkBAIC03MSw2ICs3MSwzOSBAQCBzdGF0aWMg
c3RydWN0IG5vdGlmaWVyX2Jsb2NrIGFjcGlfcGxhdGZvCiAJLm5vdGlmaWVyX2NhbGwgPSBhY3Bp
X3BsYXRmb3JtX2RldmljZV9yZW1vdmVfbm90aWZ5LAogfTsKIAorc3RhdGljIHZvaWQgYWNwaV9w
bGF0Zm9ybV9hZGp1c3RfcmVzb3VyY2Uoc3RydWN0IGFjcGlfZGV2aWNlICphZGV2LAorCQkJCQkg
IHN0cnVjdCByZXNvdXJjZSAqbmV3X3JlcywKKwkJCQkJICBjb25zdCBzdHJ1Y3QgcmVzb3VyY2Ug
KnJlc291cmNlcywKKwkJCQkJICB1bnNpZ25lZCBpbnQgY291bnQpCit7CisJdW5zaWduZWQgaW50
IGk7CisKKwlpZiAoIShuZXdfcmVzLT5mbGFncyAmIChJT1JFU09VUkNFX0lPIHwgSU9SRVNPVVJD
RV9NRU0pKSkKKwkJcmV0dXJuOworCisJZm9yIChpID0gMDsgaSA8IGNvdW50OyBpKyspIHsKKwkJ
Y29uc3Qgc3RydWN0IHJlc291cmNlICpyZXMgPSAmcmVzb3VyY2VzW2ldOworCisJCWlmIChyZXNv
dXJjZV90eXBlKG5ld19yZXMpICE9IHJlc291cmNlX3R5cGUocmVzKSkKKwkJCWNvbnRpbnVlOwor
CisJCWlmICghcmVzb3VyY2Vfb3ZlcmxhcHMobmV3X3JlcywgcmVzKSkKKwkJCWNvbnRpbnVlOwor
CisJCWRldl9pbmZvKCZhZGV2LT5kZXYsICJBZGp1c3RpbmcgcmVzb3VyY2UgJXBSIHRvICVwUlxu
IiwgbmV3X3JlcywgcmVzKTsKKwkJLyoKKwkJICogRXh0ZW5kIHRoZSBuZXcgcmVzb3VyY2UgdG8g
aW5jbHVkZSB0aGUgb25lIHRoYXQgaGFzIGJlZW4KKwkJICogcHJvY2Vzc2VkIGFscmVhZHkgdG8g
YXZvaWQgcmVzb3VyY2UgaW5zZXJ0aW9uIGZhaWx1cmVzIGR1cmluZworCQkgKiBwbGF0Zm9ybSBk
ZXZpY2UgcmVnaXN0cmF0aW9uLgorCQkgKi8KKwkJaWYgKHJlcy0+c3RhcnQgPCBuZXdfcmVzLT5z
dGFydCkKKwkJCW5ld19yZXMtPnN0YXJ0ID0gcmVzLT5zdGFydDsKKworCQlpZiAocmVzLT5lbmQg
PiBuZXdfcmVzLT5lbmQpCisJCQluZXdfcmVzLT5lbmQgPSByZXMtPmVuZDsKKwl9Cit9CisKIHN0
YXRpYyB2b2lkIGFjcGlfcGxhdGZvcm1fZmlsbF9yZXNvdXJjZShzdHJ1Y3QgYWNwaV9kZXZpY2Ug
KmFkZXYsCiAJY29uc3Qgc3RydWN0IHJlc291cmNlICpzcmMsIHN0cnVjdCByZXNvdXJjZSAqZGVz
dCkKIHsKQEAgLTE1MSwxMCArMTg0LDEyIEBAIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmFjcGlf
Y3JlYXRlX3BsYXQKIAkJCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKIAkJCX0KIAkJCWNvdW50
ID0gMDsKLQkJCWxpc3RfZm9yX2VhY2hfZW50cnkocmVudHJ5LCAmcmVzb3VyY2VfbGlzdCwgbm9k
ZSkKKwkJCWxpc3RfZm9yX2VhY2hfZW50cnkocmVudHJ5LCAmcmVzb3VyY2VfbGlzdCwgbm9kZSkg
eworCQkJCWFjcGlfcGxhdGZvcm1fYWRqdXN0X3Jlc291cmNlKGFkZXYsIHJlbnRyeS0+cmVzLAor
CQkJCQkJCSAgICAgIHJlc291cmNlcywgY291bnQpOwogCQkJCWFjcGlfcGxhdGZvcm1fZmlsbF9y
ZXNvdXJjZShhZGV2LCByZW50cnktPnJlcywKIAkJCQkJCQkgICAgJnJlc291cmNlc1tjb3VudCsr
XSk7Ci0KKwkJCX0KIAkJCWFjcGlfZGV2X2ZyZWVfcmVzb3VyY2VfbGlzdCgmcmVzb3VyY2VfbGlz
dCk7CiAJCX0KIAl9Cg==
--000000000000bb187606584ee296--
