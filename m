Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:2214 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbdJYNol (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2017 09:44:41 -0400
Date: Wed, 25 Oct 2017 15:44:38 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Kari Hiitola <kari@varaani.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Fixing CVE-2017-15361
Message-ID: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I'm implementing a fix for CVE-2017-15361 that simply blacklists
vulnerable FW versions. I think this is the only responsible action from
my side that I can do.

/arkko
