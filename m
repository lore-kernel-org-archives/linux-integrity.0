Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-ed1-f54.google.com ([209.85.208.54]:45226 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeHVXjZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Aug 2018 19:39:25 -0400
Received: by mail-ed1-f54.google.com with SMTP id p52-v6so2148723eda.12
        for <linux-integrity@vger.kernel.org>; Wed, 22 Aug 2018 13:13:06 -0700 (PDT)
MIME-Version: 1.0
From: Harlan Lieberman-Berg <harlan@dds.mil>
Date: Wed, 22 Aug 2018 16:12:35 -0400
Message-ID: <CAO-sURQqNhQ3R+REeTrWTBf=ZARB7RhBFjNdUqGS8rXZdTZp4Q@mail.gmail.com>
Subject: nvs.c: Inappropriately maps TPM space on Dell Inspiron 11 3000
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Paul Tagliamonte <paultag@dds.mil>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello maintainers,

Crossing over from a thread in linux-integrity
(<CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>),
the fTPM on the Dell Inspiron 11 3000 reports its TPM registers inside
ACPI NV space.  This causes the TPM to fail to run as the address
space has already been mapped by acpi/nvs.c prior to the TPM driver
loading.

In discussion with Jarkko and mjg, as well as contacts with the
manufacturer, this appears to something that Linux should support,
despite being arguably broken.  Because the fTPM is part of the ODM
BIOS, this isn't something that can realistically be fixed through
firmware updates; it's going to be scattered across many different
devices and many different manufacturers -- and because Windows
already works around this particular brain-damage, there's not as much
leverage that can be applied.

The full ACPI dump and the output of dmidecode can be found at
https://gist.github.com/hlieberman-gov/83fa708d41051bafccc553cf0147db4f.
I have machines that are set-aside for testing, running both Windows
10 and Debian sid, and I'm happy to help test possible fixes.

Sincerely,
-- 
Harlan Lieberman-Berg
Defense Digital Service
